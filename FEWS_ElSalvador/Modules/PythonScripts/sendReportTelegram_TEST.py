import sys
import telegram

bot = telegram.Bot(token='5218957595:AAFabMP37uZZtYSNuf_3UPyDxWQkZFAZw98')
chat_id = -#AGREGARCHATID
filename = sys.argv[1]
caption = sys.argv[2]

bot.send_photo(chat_id=chat_id, photo=open(filename, 'rb'), caption=caption)
