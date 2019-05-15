# README

Update (16 May 2019): Here's the GitHub link https://github.com/leeyihui/crypt_gemini_api
Will work on a proper Readme once I find time. For the more adventurous ones with time on your hands, you can go ahead and clone/download it, then try to have it setup on your own. Perhaps Google along the lines of "how to clone and run a rails project".
- Anyhow here's a rough guide:
 - Follow the steps at the below links until you finish "Install Rails" but stop proceeding further:
  - Windows 10 - https://gorails.com/setup/windows/10
  - MacOSX - https://gorails.com/setup/osx/10.14-mojave
 - Clone/download the repository and all files inside onto a local folder in your computer (e.g. C:\dashboard_gemini_api)
 - Edit the file "/app/services/api_gemini.rb" and replace it accordingly with your key and secret (the url is the same for everyone, and the inverted commas are required):
  - ENV["API_GEMINI_URL"]  >>  'https://api.gemini.com'
  - ENV["GEMINI_API_KEY"]  >>  'account-eXampleKEy123'
  - ENV["GEMINI_API_SECRET"]  >>  'exAMpleAPiSecReT12385484'
 - Using the command prompt(Windows)/terminal(MacOSX), navigate to your folder (e.g. C:\dashboard_gemini_api)
 - Type and run the following command:
  - bundle install
 - Required dependencies will be installed accordingly and when it's done, type and run the following command:
  - rails server
 - Go to your browser (preferably Chrome, avoid IE/Edge) and in the address bar, go to http://localhost:3000/
 - Fingers crossed, the dashboard should appear.
 - By the way, I highly recommend using your sandbox credentials first to play around with it till you're confident that it does what you want it to. Sandbox url is 'https://api.sandbox.gemini.com' and you'll need to use your sandbox api key and api secret as well.
