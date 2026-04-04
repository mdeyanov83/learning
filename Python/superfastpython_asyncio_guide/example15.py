# SuperFastPython.com
# example of executing a shell command as a subprocess with asyncio
import asyncio
 
# main coroutine
async def main():
    # start executing a shell command in a subprocess
    process = await asyncio.create_subprocess_shell('echo Hello World')
    # report the details of the subprocess
    print(f'subprocess: {process}')
 
# entry point
asyncio.run(main())
