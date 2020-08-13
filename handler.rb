require 'json'
require 'telegram/bot'
require 'aws-sdk-translate'

def translate(event:, context:)

  client = Aws::Translate::Client.new
  bot = Telegram::Bot::Client.new(ENV["TG_TOKEN"])
  message = JSON.parse(event["body"])["message"]

  translation = client.translate_text({
    text: message["text"],
    source_language_code: "auto",
    target_language_code: "DE"
  }).translated_text

  bot.api.send_message(chat_id: message["chat"]["id"], text: translation)

  {
    "statusCode": 200,
    "headers": {},
    "body": translation,
    "isBase64Encoded": false
  }

end

