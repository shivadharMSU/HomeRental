const http = require('http');
const fs = require('fs');
const path = require('path');
const url = require('url'); 

const port = 8090;

const server = http.createServer((req, res) => {
  const parsedUrl = url.parse(req.url, true); 
  const filePath = parsedUrl.pathname === '/' ? 'Main-Page.html' : parsedUrl.pathname;
  const fullPath = path.join(__dirname, filePath);

  fs.readFile(fullPath, (err, data) => {
    if (err) {
      res.writeHead(404, { 'Content-Type': 'text/plain' });
      res.end('File not found');
    } else {
      res.writeHead(200, { 'Content-Type': 'text/html' });
      res.end(data);
    }
  });
});

server.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});
