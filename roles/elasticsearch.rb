name                'elasticsearch'
description         'Elasticsearch cluster server'
run_list            'recipe[hostname]',
                    'recipe[java]',
                    'recipe[elasticsearch]',
                    'recipe[elasticsearch::plugins]'
default_attributes  elasticsearch: {
  version: "1.1.0",
  cluster: { name: "elasticsearch_vagrant" },
  plugins: {
    'karmi/elasticsearch-paramedic' => {},
    'lukas-vlcek/bigdesk' => {}
  }
}
