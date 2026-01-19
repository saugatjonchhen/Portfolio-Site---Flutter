{{flutter_js}}
{{flutter_build_config}}

// Wrapping in a block {} prevents "already declared" errors
{
  const myCustomLoader = document.getElementById("loading_indicator");

  _flutter.loader.load({
    onEntrypointLoaded: async function(engineInitializer) {
      const appRunner = await engineInitializer.initializeEngine();

      if (myCustomLoader) {
        myCustomLoader.style.transition = 'opacity 0.5s ease-out';
        myCustomLoader.style.opacity = '0';
        setTimeout(() => myCustomLoader.remove(), 500);
      }

      await appRunner.runApp();
    }
  });
}