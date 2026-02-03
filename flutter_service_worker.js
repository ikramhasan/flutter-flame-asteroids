'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "f08e41be4ab881bd22ae591f58b6adb7",
"version.json": "f9cdab68e3d7a61dd81fef3532d9b0e3",
"index.html": "974b439f693a2d992446415376cb5bcb",
"/": "974b439f693a2d992446415376cb5bcb",
"main.dart.js": "795f770174a8bd2dfbdaa7be0a42e09e",
"flutter.js": "24bc71911b75b5f8135c949e27a2984e",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "543225d2ca54c0393fc751f9e9355540",
"assets/NOTICES": "dbefd6f8266d20fd43f8cdb4a7d8a5bc",
"assets/FontManifest.json": "5dfe1412ee8a8774abe1525568ff440b",
"assets/AssetManifest.bin.json": "7718eeecba22daca0139cb6c674312dd",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/shaders/stretch_effect.frag": "40d68efbbf360632f614c731219e95f0",
"assets/AssetManifest.bin": "f6ba2b39ef430d99d12b30e35a92ef45",
"assets/fonts/MaterialIcons-Regular.otf": "c0ad29d56cfe3890223c02da3c6e0448",
"assets/assets/images/icon_exclamationSmall.png": "05563ae77600397ac0859ea0e7b69f8b",
"assets/assets/images/star_small.png": "72d9ec44ac40dc22f362f58bceaffe79",
"assets/assets/images/ship_sidesD.png": "e4aeafeef0388014207e5d3945d2d269",
"assets/assets/images/icon_plusLarge.png": "a459b6e7730a3eaacaa41d03b5a1e6c2",
"assets/assets/images/meteor_squareDetailedLarge.png": "c412741e5baf75fe9226bc45fe62ca37",
"assets/assets/images/icon_plusSmall.png": "4f51a855d4f7b9d6b1b384eca91c56ea",
"assets/assets/images/ship_sidesC.png": "58351836eaf6dfa0d4e2e7d61d16a690",
"assets/assets/images/star_tiny.png": "a5ac5074a6c5ab41bb53e14725ada8ea",
"assets/assets/images/meteor_squareDetailedSmall.png": "509f0c828f79180b0a79a01fe0678035",
"assets/assets/images/ship_sidesB.png": "fa7707817e4bcd963d65ea3bbedfbbfe",
"assets/assets/images/star_large.png": "0aaa3e3afb1e3f0bbe64f51cff611b88",
"assets/assets/images/icon_exclamationLarge.png": "9e2752b7a36934c342fb9550b15d92b1",
"assets/assets/images/ship_sidesA.png": "4033fb652557b7eadeb4255e218fe2d6",
"assets/assets/images/ship_A.png": "b1edcfb82c9195cc8bf944fd6211e357",
"assets/assets/images/meteor_small.png": "b546b9214100a50a9c6b7b0a3e5346ba",
"assets/assets/images/effect_purple.png": "3a5730d90aa154894c284c95b9a35d10",
"assets/assets/images/ship_B.png": "ce3f46234c1497eb50eaf2fa9368b56f",
"assets/assets/images/icon_crossSmall.png": "89b6ffa44ccfadc27f1caae57b1f4f6c",
"assets/assets/images/ship_C.png": "bf2f3d304737c51e05c92fa080b20fb0",
"assets/assets/images/icon_crossLarge.png": "1454ca973168bdaad96352bfdbd58255",
"assets/assets/images/ship_G.png": "3156250a6cb215c2d2b77a3a4aa98d2a",
"assets/assets/images/ship_F.png": "5c684f7e7a4e7f345e5f3a591638bd6e",
"assets/assets/images/ship_D.png": "b79d92dc288461b09733033babbdc96b",
"assets/assets/images/meteor_large.png": "620df7276aa2f338bd446e6ea18ccdc5",
"assets/assets/images/ship_E.png": "51a727a8d7f5c74d1647e39011312ac6",
"assets/assets/images/enemy_D.png": "4f06c7bfa5b14fc95de97873d14790ff",
"assets/assets/images/ship_H.png": "1e023a0b69de617989ec2baafb39df56",
"assets/assets/images/star_medium.png": "d3cea4b742b50f4b6b05f03caab27fee",
"assets/assets/images/ship_I.png": "fece74b9369753a8487d91837025659a",
"assets/assets/images/enemy_E.png": "2449c3141e6678b6d402f7645fae2285",
"assets/assets/images/ship_K.png": "0cb1406672233b8de298a445eb66fcbe",
"assets/assets/images/ship_J.png": "2867062cbf8d389c6913c1273ee74a68",
"assets/assets/images/enemy_B.png": "0608d0bc6503d6d67b2175048b72e8aa",
"assets/assets/images/station_A.png": "dc7b63db105633e6461f42c4e6b497cd",
"assets/assets/images/enemy_C.png": "379ee9bfd352ed56c2e31fc231dd906f",
"assets/assets/images/enemy_A.png": "2f44f2982a2520f9785040ee0a5bd89f",
"assets/assets/images/station_B.png": "91aea633270b83596b7df81a41b65058",
"assets/assets/images/station_C.png": "e840459249a0192ada4b7d6773026878",
"assets/assets/images/ship_L.png": "d56c4f5bfbc42a289fd73d7bcb61060b",
"assets/assets/images/meteor_squareLarge.png": "c9956e0549d2ac2997eb6361959fc75d",
"assets/assets/images/satellite_C.png": "e08e81e33d186f4feea21777ce6704e2",
"assets/assets/images/satellite_B.png": "c7f44775aad5e0aa1ef982df257683e7",
"assets/assets/images/meteor_detailedLarge.png": "0f551beeb0b89b979afa7f43710d924e",
"assets/assets/images/satellite_A.png": "4ff49c3fc09c6283942803f3f58d25b6",
"assets/assets/images/satellite_D.png": "53443f1427b1e5a76a154637b3ab7d48",
"assets/assets/images/meteor_detailedSmall.png": "3355d859e5d7acbeb4789be4e322a2d1",
"assets/assets/images/effect_yellow.png": "f7e2c4ef3ad087ea9c7da73c4f12ec2c",
"assets/assets/images/meteor_squareSmall.png": "f928e62d554ca3428dca533faa0eb75b",
"assets/assets/vectors/button_square_header_small_rectangle_screws.svg": "f87dbe1482c0ccb2cdf17d720d251750",
"assets/assets/vectors/crosshair_color_c.svg": "cd8e598c1bae5fcaba12573aae980907",
"assets/assets/vectors/bar_square_gloss_large_m.svg": "d24e08c160bd5bdc40919d742291725d",
"assets/assets/vectors/bar_square_gloss_large_l.svg": "9adc2b50a9696079ff0da27966292e3f",
"assets/assets/vectors/crosshair_color_b.svg": "d9c211b35cdbafd881f9b86522776ccf",
"assets/assets/vectors/bar_round_small_r.svg": "f0b833232b27b365c953911d9b4a0654",
"assets/assets/vectors/button_square_header_blade_rectangle_screws.svg": "f5ae7e5566a9256777f1340f2dc834cc",
"assets/assets/vectors/bar_round_gloss_large_r.svg": "5ba1da59adbf964b631c4ccd8a0b7937",
"assets/assets/vectors/button_square_header_blade_square_screws.svg": "cb236e375351d974e67c2fec352a4dd5",
"assets/assets/vectors/button_square_header_large_rectangle_screws.svg": "dfffba8aa47303b2c6eaecd423102013",
"assets/assets/vectors/crosshair_color_a.svg": "76dc07a4fe64c37ae7216f8c97c29cc9",
"assets/assets/vectors/button_square_header_notch_square.svg": "9404ce6964c8a09c2e342aa4c190d5a2",
"assets/assets/vectors/crosshair_color_d.svg": "8e64664f26a1fcbccbb7b4031dae94c1",
"assets/assets/vectors/bar_round_gloss_small_l.svg": "3e6dcb60d3bc450f79ed42a539408e27",
"assets/assets/vectors/bar_square_gloss_small_r.svg": "f159a91b2241dfc777a8986f39bc4aa7",
"assets/assets/vectors/bar_round_large_l.svg": "8b63c0ea961b372c97311f44bac00266",
"assets/assets/vectors/bar_round_large_m.svg": "1ca10069b38dcb9128a89f87e06e6bfa",
"assets/assets/vectors/bar_round_gloss_small_m.svg": "48a7d990a56e64897881a246b1e7df83",
"assets/assets/vectors/bar_square_small_l.svg": "83ff1d8de5c96e2a39d44b2aee708226",
"assets/assets/vectors/bar_square_small_m.svg": "21b9fd8a7d2106ea570edec1efb1da57",
"assets/assets/vectors/button_square_header_small_rectangle.svg": "53c7a52699bc8aefdcabf7b42f9e56e9",
"assets/assets/vectors/bar_round_gloss_small.svg": "9916ec9c75347ed68bd68fc3b1e1b34e",
"assets/assets/vectors/bar_square_gloss_large.svg": "4c97039a57d38b651760aa89b17879b5",
"assets/assets/vectors/bar_square_gloss_small.svg": "0a28e612d075092019e4dafaad2618a6",
"assets/assets/vectors/bar_round_gloss_large.svg": "0752519f2efc901dd534d699f6ae6ada",
"assets/assets/vectors/bar_square_large_r.svg": "9e674b2911a4adc879f2518bc4691b3b",
"assets/assets/vectors/bar_square_small_r.svg": "9be94ec13651cdf540541d6fbed6067a",
"assets/assets/vectors/bar_square_large.svg": "60c552b1412a6190cd144fd84da5ff93",
"assets/assets/vectors/bar_round_gloss_small_square.svg": "25b0983802af429d0ef1d7477dd029a5",
"assets/assets/vectors/bar_square_large_square.svg": "2d85e8f84fb2cf385c5e49dde856d74d",
"assets/assets/vectors/button_square_header_small_square.svg": "c1dcbe6e7b9741156cb373f3ca545f37",
"assets/assets/vectors/bar_round_gloss_large_square.svg": "ddf5e7d1b070caefac4d4885a89c770d",
"assets/assets/vectors/button_square_header_large_square.svg": "ac3e95320e0acaee96773a6b08f8f5c2",
"assets/assets/vectors/bar_square_small_square.svg": "7e316aecc3e9c1be2579f3413aef0c29",
"assets/assets/vectors/button_square_header_notch_rectangle.svg": "e28cb318f082a2dfcf98a072d0b158af",
"assets/assets/vectors/bar_round_large_square.svg": "1153fc68876d55c9265fc388afdee7b8",
"assets/assets/vectors/bar_round_small_square.svg": "29dca7973d085efada4dfa589a6fac34",
"assets/assets/vectors/bar_square_gloss_small_square.svg": "93f1d31ecc6ddf3001aa8b7cfd93c810",
"assets/assets/vectors/bar_square_small.svg": "abcb212f78071fdd8db6c05148e9ee69",
"assets/assets/vectors/bar_square_large_m.svg": "1ca10069b38dcb9128a89f87e06e6bfa",
"assets/assets/vectors/bar_square_gloss_large_square.svg": "255a4cbcae874db5cb479e13ba66b292",
"assets/assets/vectors/bar_square_large_l.svg": "14039daff7890165a6dd6ed5442fe892",
"assets/assets/vectors/bar_round_gloss_large_m.svg": "d24e08c160bd5bdc40919d742291725d",
"assets/assets/vectors/button_square_header_blade_square.svg": "1b43a7e9e33509da768066f8068082b7",
"assets/assets/vectors/bar_round_small_m.svg": "21b9fd8a7d2106ea570edec1efb1da57",
"assets/assets/vectors/button_square_header_large_rectangle.svg": "ecdb07f74e325172b3b80de09d0145e1",
"assets/assets/vectors/bar_square_gloss_large_r.svg": "5c15bf1d009b513db55d3ec67f3e3b0f",
"assets/assets/vectors/bar_round_small_l.svg": "8abe8bbdd8ad20e61d5bb5d7897a3f46",
"assets/assets/vectors/button_square_header_blade_rectangle.svg": "e83a8f5c9fb976014cc0f63f5b82bf08",
"assets/assets/vectors/bar_round_gloss_large_l.svg": "e154d7543dad4ebc2b9d70eceab7759b",
"assets/assets/vectors/bar_round_large.svg": "2e5ed2c0cf2a10748dd01b9d18355dab",
"assets/assets/vectors/button_square_header_notch_square_screws.svg": "0cf27b3ae6a2f84068c11a0e4efb9579",
"assets/assets/vectors/bar_round_small.svg": "629be0142aac10aff7d1a6b7b50288c4",
"assets/assets/vectors/button_square_header_large_square_screws.svg": "22a87142215283630dc708fbfa0a5dec",
"assets/assets/vectors/bar_round_gloss_small_r.svg": "e5d0ed104aebca12cca93e46b1ff0f04",
"assets/assets/vectors/button_square_header_small_square_screws.svg": "a800f1965e7c66361ecbf7dab9d14212",
"assets/assets/vectors/bar_square_gloss_small_l.svg": "afd61e3de252880f7ac95d2516585a2c",
"assets/assets/vectors/bar_round_large_r.svg": "87c6e3956e8f3e120c4057368688ea5c",
"assets/assets/vectors/button_square_header_notch_rectangle_screws.svg": "eb5954eafd3b1c9d667589fd1a437f01",
"assets/assets/vectors/bar_square_gloss_small_m.svg": "7615368d2fa40cca6e364588c43fea2d",
"assets/assets/audio/ENGINE%2520Motor%2520Heavy%2520Loop%252008.wav": "76f1d78e89c83880e597579730df3f76",
"assets/assets/audio/WEAPON%2520CLICK%2520Reload%2520Mechanism%252001.wav": "9083ecc51ca55f2b973955e3cb78e773",
"assets/assets/audio/NEGATIVE%2520Failure%2520Descending%2520Chime%252005.wav": "a940ef48d50a807cf0538689baa10e84",
"assets/assets/audio/SUCCESS%2520BEEPS%2520Multi%2520Echo%2520Short%252002.wav": "7760d4fdb21f6abedd8a8c39cc6cdcf5",
"assets/assets/audio/EXPLOSION%2520Bang%252004.wav": "cb1ced6f5ab9daaea656001f32cf24eb",
"assets/assets/audio/TECH%2520WEAPON%2520Gun%2520Shot%2520Phaser%2520Down%252002.wav": "2415eaa7b59abebfdcbd0a45b2da56aa",
"assets/assets/audio/COINS%2520Collect%2520Jackpot%2520Win%252003.wav": "4c2ac9352af8cd638e90ceca7351653b",
"assets/assets/audio/SPLAT%2520Crush%252001.wav": "74cbd3b98a9704d943972c4ba62401d0",
"assets/assets/audio/SUCCESS%2520CHIME%2520Bells%2520Sparkle%2520Tune%2520Completion%252005.wav": "33323f968ab3672b3fa0b8bc482de255",
"assets/assets/audio/MECH%2520Servo%2520Motor%2520Movement%2520Stomp%2520Long%252002.wav": "f1f7777e25cfa9aa570bd55d5fd683cc",
"assets/assets/audio/ELECTRIC%2520Shock%2520Zap%2520Short%252003.wav": "1ff8daa3cf89d9d8d2339c2c8ba20ce9",
"assets/assets/audio/TECH%2520INTERFACE%2520Computer%2520Terminal%2520Beeps%2520Negative%252003.wav": "1c75ca1593218937cd943f638730ea20",
"assets/assets/audio/RETRO%2520Jump%2520Up%2520Bounce%2520Long%252003.wav": "784d78a6f78170e7b52176a99a41dcc5",
"assets/assets/audio/TECH%2520CHARGER%2520Power%2520Up%252006.wav": "854f1904aed8a1e3304e03fb5580ae7f",
"assets/assets/audio/SQUEAK%2520Stretch%2520Tighten%2520Long%252001.wav": "09186287d55a11d98273adb3a05d1eae",
"assets/assets/audio/WEAPON%2520GUNSHOT%2520Rifle%2520Swish%252002.wav": "f449f6adc4cdaf59edac0dad75b2750f",
"assets/assets/audio/SHAKER%2520Pieces%2520Drop%2520Roll%252001.wav": "d65db01a07203e3ee4f358bf619e0753",
"assets/assets/audio/VOCAL%2520CUTE%2520Call%2520Affection%252003.wav": "a6b67977b3d0bd579432318f17997a30",
"assets/assets/audio/FOOTSTEPS%2520(A)%2520Walking%2520Loop%252001.wav": "3d482b443caabf95a1c8b6c54da09622",
"assets/assets/audio/WATER%2520Bubbles%252002.wav": "3ca039759136d5cfcd109b6a75e82e51",
"assets/assets/audio/BOUNCE%2520Twang%2520Spring%252013.wav": "853117793ee0cf83239ef4d1f689b2e1",
"assets/assets/audio/SWIPE%2520Whoosh%2520Double%252001.wav": "b9f5afe4a12cae9d6f1d1cadacf96f98",
"assets/assets/audio/SUCCESS%2520PICKUP%2520Collect%2520Chime%252001.wav": "12a4e6cfcedb7d348e3bccec0d194587",
"assets/assets/audio/IMPACT%2520Metal%2520Blade%2520Clang%252001.wav": "7f05be1722119941cb62282cfaf398a7",
"assets/assets/audio/VOCAL%2520EVIL%2520Impact%2520Hit%2520Slash%252004.wav": "47d794fc1061ae1d9fc545a9138d863e",
"assets/assets/audio/POP%2520Echo%2520Bouncer%252001.wav": "974a944a7dccc12f2dc9b75775294127",
"assets/assets/audio/SUCCESS%2520CHEERS%2520Win%2520Cute%2520Vocal%2520Chime%252003.wav": "5edd5a8288000b671b3e2c130356e774",
"assets/assets/audio/SLIDER%2520Swipe%2520Drag%2520Movement%2520Stone%252008.wav": "975f2492b523a61319d7d8a1c4051a03",
"assets/assets/audio/ALARM%2520Alert%2520Ringer%2520Ascend%252001.wav": "f0be8c13a51688e02012f6d3f3bb1dd6",
"assets/assets/audio/BONG%2520Bell%2520Timer%2520Hit%2520Deep%252001.wav": "56777fe8c64be5fc35140b5cd0a66b77",
"assets/assets/fonts/Kenney%2520Future.ttf": "43ca78dbf62b6e6514fd3d0a77bc7221",
"assets/assets/fonts/Kenney%2520Future%2520Narrow.ttf": "49ad31a458ddb19cec86d01f213ae251",
"canvaskit/skwasm.js": "8060d46e9a4901ca9991edd3a26be4f0",
"canvaskit/skwasm_heavy.js": "740d43a6b8240ef9e23eed8c48840da4",
"canvaskit/skwasm.js.symbols": "3a4aadf4e8141f284bd524976b1d6bdc",
"canvaskit/canvaskit.js.symbols": "a3c9f77715b642d0437d9c275caba91e",
"canvaskit/skwasm_heavy.js.symbols": "0755b4fb399918388d71b59ad390b055",
"canvaskit/skwasm.wasm": "7e5f3afdd3b0747a1fd4517cea239898",
"canvaskit/chromium/canvaskit.js.symbols": "e2d09f0e434bc118bf67dae526737d07",
"canvaskit/chromium/canvaskit.js": "a80c765aaa8af8645c9fb1aae53f9abf",
"canvaskit/chromium/canvaskit.wasm": "a726e3f75a84fcdf495a15817c63a35d",
"canvaskit/canvaskit.js": "8331fe38e66b3a898c4f37648aaf7ee2",
"canvaskit/canvaskit.wasm": "9b6a7830bf26959b200594729d73538e",
"canvaskit/skwasm_heavy.wasm": "b0be7910760d205ea4e011458df6ee01"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
