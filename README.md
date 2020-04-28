# Clickr
[![Travis services/web build Status](https://travis-ci.com/ftes/clickr.svg?branch=master)](https://travis-ci.com/ftes/clickr)
[![Maintainability](https://api.codeclimate.com/v1/badges/920d988e3507a9077561/maintainability)](https://codeclimate.com/github/ftes/clickr/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/920d988e3507a9077561/test_coverage)](https://codeclimate.com/github/ftes/clickr/test_coverage)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

**Designed to motivate: A student response system for schools.**

[**Live Demo**](http://clickr.ftes.de) (credentials: `f@ftes.de` / `password`, might take ~10 seconds to start heroku dyno).

![Clickr Diagram](docs/images/diagram_small.png)

**For teachers:**
- Give oral grades based on the response data, rather than a gut feeling.
- Spend less time taking notes on student participation after or during each lesson. 

**For students:**
- Motivation for participation: Immediately see how your oral grade improves.
- Continuously reflect on your participation.

![Clickr Screencast](docs/videos/screencast.gif)

## Features
- **Class and seating plan management:** Visual drag and drop editor.
- **Question mode:** Teacher opens question response timebox, students can respond by clicking.
- **Special merits:** Bump the student grade after outstanding responses.
- **Lesson Evaluation:** Interactive grading, based on response average.
- **Student grades:** Calculate grade suggestion based on student's participation.
- _Coming soon: Class list import (excel, csv)._
- _Coming soon: Student photo support._
- _Coming soon: "Name the student" - Learning mode for teacher using student photos._


## Tech Stack
- **Web app:** [Ruby on Rails](https://rubyonrails.org/), [PostgreSQL](https://www.postgresql.org/)
- **Zigbee input adapter:** [Node.js](https://nodejs.org/), [zigbee-herdsman](https://github.com/Koenkk/zigbee-herdsman)
- **CI/CD:** [TravisCI](https://travis-ci.com/), [heroku](https://www.heroku.com/) (cloud preview) [balena.io](https://www.balena.io/) (embedded device management)

<!-- TODO Generate interaction diagram from distributed dot/graphviz comments -->


## Getting started (clickr/web development)
<!-- TODO Double check -->
1. `cd services/web`
2. `bundle install`
3. `bundle exec rails db:create db:migrate db:seed`
4. `rails s`
5. `xdg-open http://localhost:3000` (credentials: `f@ftes.de`/`password`)


## Repository layout
<!-- $ tree -L 2 --filelimit 20 -d -->
```
├── bin
├── docs
│   └── adr
└── services
    ├── web
    └── zigbee
```


## Further topics
- [Running in production](./docs/running-in-production.md)
- [Configuration](./docs/configuration.md)
- [Architectural decisions](./docs/adr)
- [Docker build](./docs/docker-build.md)
- [Heroku demo](./docs/heroku.md)
