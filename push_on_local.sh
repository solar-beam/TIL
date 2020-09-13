#!/bin/bash
git checkout master
git merge local
git push github master
git checkout local
