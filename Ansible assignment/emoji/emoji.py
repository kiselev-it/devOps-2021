from flask import Flask, jsonify, request, abort
import emoji
from emoji import UNICODE_EMOJI_ENGLISH
app = Flask(_name_)

@app.errorhandler(404)
def resource_not_found(e):
    return jsonify(error=str(e)), 404

@app.errorhandler(405)
def resource_not_found(e):
    return jsonify(error=str(e)), 405

@app.route('/', methods=['POST'])
def post_route():
    phrase = ''
    if request.method == 'POST':
        word = request.json.get('word')
        count = request.json.get('count')
        if word and count:
            default_emoji = emoji.emojize(':thumbs_up:')
            word_emoji = emoji.emojize(':{}:'.format(word), use_aliases=True)
            used_emoji = word_emoji if word_emoji in UNICODE_EMOJI_ENGLISH else default_emoji

            phrase = used_emoji + (word + used_emoji) * count  + '\n'
        else:
            abort(404, description="You need to specify the word and count")

    return phrase

if _name_ == '_main_':
    app.run(host="0.0.0.0", port=sys.argv[1])
