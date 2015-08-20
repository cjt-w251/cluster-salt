kibana:
  archive.extracted:
    - name: /usr/local/
    - source_hash: sha1=d43e039adcea43e1808229b9d55f3eaee6a5edb9
    - source: https://download.elastic.co/kibana/kibana/kibana-4.1.1-linux-x64.tar.gz
    - archive_format: tar
    - tar_options: -z --transform=s,/*[^/]*,kibana,
    - if_missing: /usr/local/kibana/
/usr/local/kibana/config/kibana.yml:
  file.managed:
    - source: salt://kibana/kibana.yml
    - overwrite: true
