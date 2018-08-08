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

module.exports = router;