# HA Redirect

Will redirect HTTP request received on HTTP (port 80) to HTTPS (port 443).


## Installation

1. Assumption is that you have SSL configured in Home Assistant with port 443
used for HTTTPS access and nothing running on port 80.

2. Go back to the **Settings**, **Apps**, **Install App**, click on "hamburger
menu" (⋮) and select click **Repositories**. Fill in `https://github.com/medo64/haredirect`
and click **Add**. Once repository is added, go back to **Install App** and
select **HA Redirect**.

[![Open your Home Assistant instance and show the add app repository dialog with a specific repository URL pre-filled.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2Fmedo64%2Fharedirect)

3. Click on the app and press **Install** and wait till the app is installed.

4. Adjust ports if needed (default is port 80 redirecting to 443).

5. Start the app by going to Info and click **Start**.

Now, when you access HTTP port, you should be redirected to HTTPS.
