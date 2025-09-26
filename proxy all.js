export default {
  async fetch(request, env, ctx) {
    let url = new URL(request.url);

    // 默认转发到 embyplus.org
    url.hostname = "embyplus.org";
    url.protocol = "https:";

    // 如果是流媒体子域名路径，转发到 stream.embyplus.org
    if (url.pathname.startsWith("/stream")) {
      url.hostname = "stream.embyplus.org";
      url.protocol = "https:";
    }

    // 保留原始请求方法和头
    let new_request = new Request(url, {
      method: request.method,
      headers: request.headers,
      body: request.body,
      redirect: "follow"
    });

    return fetch(new_request);
  }
}
