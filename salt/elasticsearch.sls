elasticsearch:
  archive.extracted:
    - name: /usr/local/
    - source_hash: sha1=619bb967f4c0eca0ec39b19fc862f16754dfef9a
    - source: https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.7.0.tar.gz
    - archive_format: tar
    - tar_options: -z --transform=s,/*[^/]*,elasticsearch,
    - if_missing: /usr/local/elasticsearch/
/usr/local/elasticsearch/config/elasticsearch.yml:
  file.managed:
    - template: jinja
    - source: salt://elasticsearch/elasticsearch.yml
    - overwrite: true
/data/elasticsearch:
  file.directory
/data/elasticsearch/data:
  file.directory
/data/elasticsearch/work:
  file.directory
/data/elasticsearch/logs:
  file.directory
/data/elasticsearch/plugins:
  file.directory
