const fs = require('fs');
const path = require('path');

const memesDir = path.join(__dirname, '..', 'memes');
const outputFile = path.join(__dirname, '..', 'memes.json');

const allowedExts = new Set(['.jpg', '.jpeg', '.png', '.webp', '.gif']);

if (!fs.existsSync(memesDir)) {
  console.warn("Memes folder not found, making sure it exists...");
  fs.mkdirSync(memesDir, { recursive: true });
}

const files = fs.readdirSync(memesDir)
  .filter(file => allowedExts.has(path.extname(file).toLowerCase()))
  .map(file => `memes/${file}`);

fs.writeFileSync(outputFile, JSON.stringify(files, null, 2), 'utf-8');
console.log(`Updated memes.json with ${files.length} image(s) for Vercel build.`);
