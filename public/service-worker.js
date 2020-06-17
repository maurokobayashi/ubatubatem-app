const CacheStatic = 'static-cache'; // for fonts and icons
const CacheDynamic = 'dynamic-cache';

// Cache Assets
// A list of local resources we always want to be cached.
const assets = [
  'https://fonts.googleapis.com/css?family=Inter:400,500,700&display=swap',
  'https://unpkg.com/ionicons@5.0.0/dist/ionicons/ionicons.js'
];

// Cache Size Limits
const limitCacheSize = (name, size) => {
  caches.open(name).then(cache => {
    cache.keys().then(keys => {
      if (keys.length > size) {
        console.log("Cache limit reached. Deleting...")
        cache.delete(keys[0]).then(limitCacheSize(name, size));
      }
    });
  });
};

// Install Service Workers
self.addEventListener('install', evt => {
  evt.waitUntil(
    caches.open(CacheStatic).then((cache) => {
      cache.addAll(assets);
      console.log('static cache success!');
    })
  );
});

// Active Service Workers
self.addEventListener('activate', evt => {
  evt.waitUntil(
    caches.keys().then(keys => {
      return Promise.all(keys
        .filter(key => key !== CacheStatic && key !== CacheDynamic)
        .map(key => caches.delete(key))
      );
    })
  );
});

// Fetch
self.addEventListener('fetch', evt => {
  // não cacheia recursos em localhost ou conteúdos com paginação will_paginate (js)
  if (evt.request.url.indexOf('localhost:3000') === -1 && evt.request.url.indexOf('page=') === -1 && evt.request.url.indexOf('cdninstagram.com') === -1) {
    // não cacheia recursos do tipo html, apenas assets
    if (evt.request.destination != 'document') {
      // responde com cache local. se não encontrar, faz um fetch para o servidor e atualiza o cache
      // problema: se o recurso já está em cache, ele não atualiza com conteúdo novo do servidor
      evt.respondWith(
        caches.match(evt.request).then(cacheRes => {
          return cacheRes || fetch(evt.request).then(fetchRes => {
            return caches.open(CacheDynamic).then(cache => {
              cache.put(evt.request.url, fetchRes.clone());
              limitCacheSize(CacheDynamic, 200);
              return fetchRes;
            })
          });
        }).catch(() => {
          if (evt.request.url.indexOf('.html') > -1) {
            return caches.match('index.html');
          }
        })
      );
    }
  }
});


let deferredPrompt;
self.addEventListener('beforeinstallprompt', evt => {
  // Prevent the mini-infobar from appearing on mobile
  // e.preventDefault();
  // Stash the event so it can be triggered later.
  deferredPrompt = evt;
  // Update UI notify the user they can install the PWA
  // showInstallPromotion();
  console.log("beforeinstallprompt");
});