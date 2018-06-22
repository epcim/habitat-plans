
{{#if bind.storage }}
{{#eachAlive bind.storage.members as |member| }}
{{~#if @first}}
storage "{{cfg.storage.engine}}" {
  {{#if cfg.storage.engine == "etcd" }}
  address = "https://{{ member.sys.ip }}:{{member.cfg.client-port}}"
  etcd_api = "v3"
  sync = true

  {{#if cfg.storage.tls.enabled }}
  tls_ca_file = {{cfg.storage.tls.ca_file}}
  tls_cert_file = {{cfg.storage.tls.cert_file}}
  tls_key_file = {{cfg.storage.tls.key_file}}
  {{/if}}

  {{else}}
  address = "https://{{ member.sys.ip }}:{{member.cfg.port}}"
  {{/if}}
  path = "{{cfg.storage.path}}"
}
{{~/if}}
{{/eachAlive}}

{{else}}

storage "{{cfg.storage.engine}}" {
  address = "{{cfg.storage.location}}:{{cfg.storage.port}}"
  path = "{{cfg.storage.path}}"
}
{{/if}}

listener "{{cfg.listener.type}}" {
  address = "{{cfg.listener.location}}:{{cfg.listener.port}}"
  tls_disable = {{cfg.listener.tls_disable}}

  {{#if not cfg.listener.tls_disable and cfg.listener.tls.enabled}}
  tls_cert_file = {{cfg.listener.tls.cert_file}}
  tls_key_file = {{cfg.listener.tls.key_file}}
  tls_min_version = {{cfg.listener.tls.min_version}}
  tls_client_ca_file  = {{cfg.listener.tls.ca_file}}
  {{/if}}
}

ui = {{cfg.ui.enabled}}
