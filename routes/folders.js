"use strict";

const express = require('express');
const knex = require('../knex');

const router = express.Router();

/* ========== GET/READ ALL FOLDERS ========== */
router.get("/", (req, res, next) => {
  knex.select("id", "name")
    .from("folders")
    .then(results => {
      res.json(results);
    })
    .catch(err => next(err));
});

/* ========== GET/READ SINGLE FOLDER ========== */
router.get("/:id", (req, res, next) => {
  const folderId = req.params.id;
  knex.select("id", "name")
    .from("folders")
    .where("id", folderId)
    .then(result => {
      if(result) {
        res.json(result);
      } else {
        next();
      }
    })
    .catch(err => next(err));
});

/* ========== POST/CREATE FOLDER ========== */
router.post("/", (req, res, next) => {
  const newFolder = {};

  if("name" in req.body) {
    newFolder.name = req.body.name;
  } else {
    const err = new Error("Missing `name` in request body");
    err.status = 400;
    return next(err);
  }

  knex.insert(newFolder)
    .into("folders")
    .returning(["id", "name"])
    .then((results) => {
      const result = results[0];
      res.location(`${req.originalUrl}/${result.id}`).status(201).json(result);
    })
    .catch(err => {
      next(err);
    });
});


/* ========== PUT/UPDATE A SINGLE FOLDER ========== */
router.put("/:id", (req, res, next) => {
  const folderId = req.params.id;
  const updateObj = {};

  if("name" in req.body) {
    updateObj.name = req.body.name;
  } else {
    const err = new Error("Missing `name` in request body");
    err.status = 400;
    return next(err);
  }

  knex.update(updateObj)
    .from("folders")
    .where("id", folderId)
    .returning(["id", "name"])
    .then(([result]) => {
      if(result) {
        res.json(result);
      } else {
        next();
      }
    })
    .catch(err => {
      next(err);
    });
});

/* ========== DELETE/REMOVE A SINGLE FOLDER ========== */
router.delete("/:id", (req, res, next) => {
  knex.del()
    .where("id", req.params.id)
    .from("folders")
    .then(() => {
      res.status(204).end();
    })
    .catch(err => {
      next(err);
    });
});

module.exports = router;