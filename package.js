Package.describe({
  summary: "Reactive variables that contain EJSON values",
  version: "1.1.0",
  git: "https://github.com/awwx/meteor-variable.git"
});

Package.on_use(function (api) {
  api.versionsFrom("METEOR-CORE@0.9.0-rc9");
  api.use(["coffeescript", "deps", "ejson"], ["client", "server"]);
  api.export("Variable", ["client", "server"]);
  api.add_files("variable.coffee", ["client", "server"]);
});

Package.on_test(function (api) {
  api.use(["coffeescript", "tinytest", "awwx:variable"]);
  api.add_files("variable-tests.coffee", ["client", "server"]);
});
