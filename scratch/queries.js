'use strict';

const knex = require('../knex');

// let searchTerm = 'cat';
// knex.select('notes.id', 'title', 'content')
//   .from('notes')
//   .modify(function (queryBuilder) {
//     if (searchTerm) {
//       queryBuilder.where('title', 'like', `%${searchTerm}%`);
//     }
//   })
//   .orderBy('notes.id')
//   .then(results => {
//     console.log(JSON.stringify(results, null, 2));
//   })
//   .catch(err => {
//     console.error(err);
//   });

// const id = 1004;
// knex.select("id", "title", "content")
//   .from("notes")
//   .where("id", id)
//   .then(result => {
//     console.log(result);
//   })
//   .catch(err => {
//     console.error(err);
//   });

let findId = 1003;
let newTitle = "Blah Blah";
let newContent = "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Commodi reiciendis deleniti at quis perspiciatis harum!";
knex
  .select("id")