Package.describe({
  summary: "Simple reactive variables that contain EJSON values"
});

Package.on_use(function (api) {
  api.use(['coffeescript', 'deps', 'ejson'], ['client', 'server']);
  if (api.export) {
    api.export('Variable', ['client', 'server']);
  }
  api.add_files('variable.coffee', ['client', 'server']);
});

Package.on_test(function (api) {
  api.use(['coffeescript', 'tinytest', 'variable', 'underscore']);
  api.add_files('variable-tests.coffee', ['client', 'server']);
});
