from draftsman.utils import string_to_JSON, JSON_to_string


def get_json(filename: str):
    with open(filename) as my_file:
        return string_to_JSON(my_file.read())


def replace_fuel_in_json(blueprint):
    if 'blueprint_book' in blueprint:
        name = blueprint['blueprint_book']['label']
        print(f'skipping blueprint book {name}')
        return

    entities = blueprint['blueprint']['entities']
    entity: dict
    for entity in entities:
        if 'request_filters' in entity:
            requests = entity['request_filters']
            if len(requests) == 1 and requests[0]['name'] == 'fuel':
                requests[0]['name'] = 'advanced-fuel'


json = get_json('railway.base64')
for bp in json['blueprint_book']['blueprints']:
    replace_fuel_in_json(bp)
encoded = JSON_to_string(json)
with open('out.base64', 'w+') as f:
    f.write(encoded)
