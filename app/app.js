const http = require('http');
const port = 3000;

const server = http.createServer((req, res) => {
  res.writeHead(200, {'Content-Type': 'text/plain'});
  res.end('Hello from Ansible Deployed App - Task 5!\n');
});

server.listen(port, () => {
  console.log(`App running on port ${port}`);
});
