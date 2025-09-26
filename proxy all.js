export default {
  async fetch(request, env) {
    let url = new URL(request.url);

    // 默认反代到 embyplus.org
    url.hostname = "embyplus.org";
    url.protocol = "https:"; // 源站是 https，必须加上

    // 如果路径是 /stream 开头，则反代到 stream.embyplus.org
    if (url.pathname.startsWith("/stream")) {
      url.hostname = "stream.embyplus.org";
      url.protocol = "https:";
    }

    // 转发请求
    let new_request = new Request(url, request);
    return fetch(new_request);
  }
}
