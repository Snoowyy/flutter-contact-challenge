# Flutter Template

Flutter contacts challenge project - A simple CRUD app. This app provides a CRUD connected with a API project using Django Rest Framework.

The app has basic login, list of contacts and management of the contacts.

It's configured with [SharedPreferences] for persistent state management, [DotEnv] for the environment variables management and [Http] for the requests.

<br />
<div>
  &emsp;&emsp;&emsp;
  <img src="https://github.com/Snoowyy/flutter-contact-challenge/blob/main/screenshots/login.png" alt="Login Page" width="330">
  &emsp;&emsp;&emsp;&emsp;
  <img src="https://github.com/Snoowyy/flutter-contact-challenge/blob/main/screenshots/list.png" alt="Home Page" width="330">
  &emsp;&emsp;&emsp;&emsp;
  <img src="https://github.com/Snoowyy/flutter-contact-challenge/blob/main/screenshots/add.png" alt="Add Contact Page" width="330">
  &emsp;&emsp;&emsp;&emsp;
  <img src="https://github.com/Snoowyy/flutter-contact-challenge/blob/main/screenshots/edit.png" alt="Edit Contact Page" width="330">
</div>
<br />

[SharedPreferences]: https://pub.dev/packages/shared_preferences
[DotEnv]: https://pub.dev/packages/flutter_dotenv
[Http]: https://pub.dev/packages/http

# Run the project

The project is configured with a environments variable, the first step before run is copy the `env.example`, remove the `.example` and add into the start `.` remaining like this `.env`.

After this replace the API_HOST value into the `.env ` file with your computer IP.

After installing the package dependencies with 

```
flutter pub get
```

And run the code

```
flutter run
```

# Tests

The test package contains unit tests for almost all components. Be sure to give it a look.