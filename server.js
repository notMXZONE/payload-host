const http = require('http');
const fs = require('fs');
const path = require('path');

const server = http.createServer((req, res) => {
  if (req.url === '/payload.exe') {
    const filePath = path.join(__dirname, 'payload.exe');
    const stat = fs.statSync(filePath);
    res.writeHead(200, {
      'Content-Type': 'application/octet-stream',
      'Content-Length': stat.size
    });
    const readStream = fs.createReadStream(filePath);
    readStream.pipe(res);
  } else {
    res.writeHead(404);
    res.end('Not Found');
  }
});

server.listen(process.env.PORT || 3000, () => {
  console.log('Server is running on port 3000');
});
