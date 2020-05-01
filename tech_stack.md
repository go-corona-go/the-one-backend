# Tech Stack for WFTO Covid PPE

|Item | Tool Used | Free(Yes/No) | Expiry Time/Capacity Limitations| What to do on expiry? | Alternatives |
|-----|-----------|--------------|---------------------------------|-----------------------|--------------|
|Primary Hosting | Hasura on Heroku| Yes | [Capacity Limitation](https://www.heroku.com/free| <ul><li>Verify the account to get extra hours</li><li>Create a new account and migrate the data</li></ul>| |
|Authentication| Auth0 | Max Limit of 7000 users | [Capacity Limitation](https://auth0.com/pricing/) upto 700 users| Get the developer upgrade| |
|Image Upload | Azure Blob Store | 12 months 5GB| Need to pay or open a new account if older images not needed| AWS|
|Sending Emails|SendGrid||||
|Secondary Hosting(Custom Logic)| Node.js+now.sh| No cost for small projects|||
