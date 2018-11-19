# Stitch in Time time keeping application

This application is built for [Atelier Oliphant](http://www.instagram.com/atelieroliphant) to help track time spent and progress on contracted projects.

## Getting started

To get started with the app, clone the repo and then install the needed gems:

```
$ bundle install --without production
```

Next, migrate the database:

```
$ rails db:migrate
```

Finally, run the test suite to verify that everything is working correctly:

```
$ rspec
```

If the test suite passes, you'll be ready to run the app in a local server:

```
$ rails server
```

For more information, contact the [developer](mailto:kilted.dev@gmail.com).
