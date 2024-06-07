import discord
import os
from discord.ext import commands

TOKEN = kani_TOKEN
# TOKEN = os.getenv('cps_TOKEN')  # カスタム大会bot

intents = discord.Intents.default()
intents.message_content = True  # メッセージコンテンツの意図を有効にする

bot = commands.Bot(command_prefix='!', intents=intents)

@bot.event
async def on_ready():
    print(f'We have logged in as {bot.user}')

@bot.event
async def on_message(message):
    if message.author == bot.user:
        return

    await message.channel.send(message.content)

bot.run(TOKEN)
