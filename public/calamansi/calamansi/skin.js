;(function () {
    CalamansiEvents.on('initialized', function (instance) {
        var player = instance.el;

        if (player.matches('.calamansi-skin--calamansi')) {
            if (document.querySelectorAll(`script[src="https://unpkg.com/simplebar@4.2.3/dist/simplebar.min.js"]`).length == 0) {
                var script = document.createElement('script');
                script.setAttribute('src', 'https://unpkg.com/simplebar@4.2.3/dist/simplebar.min.js');
                script.setAttribute('type', 'text/javascript');
                document.querySelector('head').appendChild(script);
            }

            var info = player.querySelector('.calamansi-skin--calamansi .clmns--info');

            player.querySelectorAll('.calamansi-skin--calamansi .clmns--toggle-playlist').forEach(function (el) {
                el.addEventListener('change', function (e) {
                    info.classList.toggle('clmns--show-playlist');
                });
            });

            var controls = player.querySelector('.clmns--controls');

            if (controls.offsetWidth < 300) {
                controls.classList.add('clmns--compact');
            }
        }
    });
})();