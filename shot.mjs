import { chromium } from '/home/glorg/Projects/openfrag-design-capture/node_modules/playwright/index.mjs';

const url = process.argv[2] ?? 'http://127.0.0.1:8471/viewer/';
const out = process.argv[3] ?? '/home/glorg/Pictures/cs2-dust2-physics-viewer.png';

const browser = await chromium.launch({
  args: ['--use-angle=swiftshader-webgl', '--disable-gpu'],
});
const page = await browser.newPage({ viewport: { width: 1600, height: 900 } });
page.on('console', (m) => console.log('[console]', m.text()));
page.on('pageerror', (e) => console.log('[pageerror]', e.message));
await page.goto(url, { waitUntil: 'domcontentloaded', timeout: 30000 });
await page.waitForFunction(
  () => /tri|error/i.test(document.body.innerText),
  { timeout: 60000 },
);
await page.waitForTimeout(3000);
console.log('[overlay]', await page.evaluate(() => document.body.innerText.replace(/\n/g, ' | ')));
await page.screenshot({ path: out });
await browser.close();
console.log('saved', out);
