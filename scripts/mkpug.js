#!/usr/bin/env node

const pug = require("pug");
const fs  = require("fs");

const inFName = process.argv[2];
const outFName = process.argv[3];

const rendered = pug.renderFile(inFName);
fs.writeFileSync(outFName, rendered);
