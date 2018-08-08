"use strict";

const express = require("express");
const knex = require("../knex");

const router = express.Router();

/* ========== GET/READ ALL NOTES ========== */
router.get("/", (req, res, next) => {
  const { searchTerm, folderId } = req.query;

  knex.select("notes.id", "title", "content", "folders.id as folderId", "folders.name as folderName")
    .from("notes")
    .leftJoin("folders", "notes.folder_id", "folders.id")
    .modify(function (queryBuilder) {
      if (searchTerm) {
        queryBuilder.where("title", "like", `%${searchTerm}%`);
      }
    })
    .modify(function (queryBuilder) {
      if(folderId) {
        queryBuilder.where("folder_id", folderId);
      }
    })
    .orderBy("notes.id")
    .then(results => {
      res.json(results);
    })
    .catch(err => {
      next(err);
    });
});

/* ========== GET/READ SINGLE NOTES ========== */
router.get("/:id", (req, res, next) => {
  const noteId = req.params.id;

  knex.first("notes.id", "title", "content", "folders.id as folderId", "folders.name as folderName")
    .from("notes")
    .leftJoin("folders", "notes.folder_id", "folders.id")
    .where("notes.id", noteId)
    .then(result => {
      if (result) {
        res.json(result);
      } else {
        next();
      }
    })
    .catch(err => {
      next(err);
    });
});

/* ========== POST/CREATE ITEM ========== */
router.post('/', (req, res, next) => {
  const { title, content, folderId } = req.body; // Add `folderId` to object destructure

  /***** Never trust users. Validate input *****/
  if (!title) {
    const err = new Error("Missing `title` in request body");
    err.status = 400;
    return next(err);
  }

  const newItem = {
    title: title,
    content: content,
    folder_id: folderId  // Add `folderId`
  };

  let noteId;

  // Insert new note, instead of returning all the fields, just return the new `id`
  knex.insert(newItem)
    .into('notes')
    .returning('id')
    .then(([id]) => {
      noteId = id;
      // Using the new id, select the new note and the folder
      return knex.select('notes.id', 'title', 'content', 'folder_id as folderId', 'folders.name as folderName')
        .from('notes')
        .leftJoin('folders', 'notes.folder_id', 'folders.id')
        .where('notes.id', noteId);
    })
    .then(([result]) => {
      res.location(`${req.originalUrl}/${result.id}`).status(201).json(result);
    })
    .catch(err => next(err));
});

/* ========== PUT/UPDATE A SINGLE ITEM ========== */
router.put("/:id", (req, res, next) => {
  const noteId = req.params.id;
  /***** Never trust users. Validate input *****/
  const updateObj = {};
  const updateableFields = ["title", "content", "folder_id"];
  updateableFields.forEach(field => {
    if (req.body.folderId) {
      updateObj["folder_id"] = req.body.folderId;
    }
    if (field in req.body) {
      updateObj[field] = req.body[field];
    }
  });

  if (updateObj.title === "") {
    const err = new Error("Missing `title` in request body");
    err.status = 400;
    return next(err);
  }

  // They send us folder name that it should be changed to DONE
  // we then lookup what the folder id is depending on the name DONE
  // if we can't find the folder, figure out if it's an error or if we need to create the folder
  // we then go back to the notes tables and change the folder id to the one we now have

  knex("notes")
    .update(updateObj)
    .where("notes.id", noteId)
    .returning(["notes.id", "notes.title", "notes.content", "folder_id as folderId"])
    .then(([result]) => {
      if (result) {
        res.json(result);
      } else {
        next();
      }
    })
    .catch(err => {
      next(err);
    });
});

/* ========== DELETE/REMOVE A SINGLE ITEM ========== */
router.delete("/:id", (req, res, next) => {
  knex.del()
    .where("id", req.params.id)
    .from("notes")
    .then(() => {
      res.status(204).end();
    })
    .catch(err => {
      next(err);
    });
});

module.exports = router;