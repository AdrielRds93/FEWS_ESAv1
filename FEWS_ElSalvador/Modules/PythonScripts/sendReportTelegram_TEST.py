import sys
import asyncio
import telegram

async def main():
	bot = telegram.Bot(token='5218957595:AAFabMP37uZZtYSNuf_3UPyDxWQkZFAZw98')
	chat_id = -1001510346693
	filename = sys.argv[1]
	caption = sys.argv[2]

	async with bot:
		await bot.send_photo(chat_id=chat_id, photo=open(filename, 'rb'), caption=caption)

if __name__ == '__main__':
    asyncio.run(main())