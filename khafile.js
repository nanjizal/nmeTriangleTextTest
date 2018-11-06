let project = new Project('Test Text Triangle');
project.addAssets('Assets/**');
project.addShaders('Shaders/**');
project.addLibrary("trilateralXtra");
project.addLibrary("trilateral");
project.addSources('src');
project.windowOptions.width = 800;
project.windowOptions.height = 600;
resolve( project );