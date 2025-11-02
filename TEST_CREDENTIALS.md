# NovaHealth - Test Credentials

## Test User Account

**IMPORTANT:** Since this app uses local storage (Hive), you need to create an account through the signup process. There are NO pre-existing accounts.

### How to Create a Test Account:

1. **Launch the app** (it will open on the Landing Page)
2. **Click "SIGNUP"**
3. **Fill in the signup form:**
   - Username: `testuser`
   - Email: `test@novahealth.com`
   - Password: `Test@123`
   - Confirm Password: `Test@123`
4. **Click "SIGNUP"** button
5. **Select Gender** (Male/Female/Other)
6. **Done!** You'll be logged in automatically

### Subsequent Logins:

After creating the account, you can login with **EITHER**:
- **Email:** `test@novahealth.com` + Password: `Test@123`
- **Username:** `testuser` + Password: `Test@123`

---

## Quick Test Credentials (Recommended)

For quick testing, use these credentials:

### Option 1 - Simple Test User
```
Username: testuser
Email: test@novahealth.com
Password: Test@123
```

### Option 2 - John Doe
```
Username: johndoe
Email: john@example.com
Password: Password@123
Full Name: John Doe
Gender: Male
```

### Option 3 - Jane Smith
```
Username: janesmith
Email: jane@example.com
Password: Secure@456
Full Name: Jane Smith
Gender: Female
```

---

## Password Requirements

All passwords must meet these requirements:
- ✅ At least 8 characters
- ✅ At least one uppercase letter (A-Z)
- ✅ At least one lowercase letter (a-z)
- ✅ At least one number (0-9)

Examples of valid passwords:
- `Test@123`
- `Password@123`
- `MyHealth2025`
- `Secure@456`

---

## Testing Different Features

### 1. Authentication Flow
- ✅ Signup → Create account with testuser
- ✅ Login → Use email OR username to login
- ✅ Forgot Password → Click "Forgot Password?" on login page

### 2. Profile Management
- ✅ View Profile → Navigate to Profile tab
- ✅ Edit Profile → Click edit icon in profile
- ✅ Change Password → Settings → Change Password
- ✅ Upload Photo → Edit Profile → Click camera icon

### 3. Settings
- ✅ Access Settings → Click settings icon in profile
- ✅ Delete Account → Settings → Danger Zone (requires password)

### 4. Dashboard
- ✅ View Stats → Home tab shows health overview
- ✅ Quick Actions → Log water, meals, workouts, mood

---

## Important Notes

1. **Local Storage Only:**
   - All data is stored locally in your browser
   - No backend server or cloud sync
   - Clear browser data = lose all accounts

2. **Profile Pictures:**
   - Web version may have camera limitations
   - Use "Gallery" option to upload images
   - Images stored as local file paths

3. **Demo Limitations:**
   - Email features (password reset) won't actually send emails
   - Notification features are UI-only (no actual notifications)
   - Export data feature is placeholder

4. **Auto-Login:**
   - Once logged in, app remembers you
   - Close and reopen browser → still logged in
   - Must manually logout to test login again

---

## Troubleshooting

### Can't Login?
- Make sure you created the account first via Signup
- Try using username instead of email (or vice versa)
- Password is case-sensitive
- Check password requirements

### Lost Password?
- No email recovery in demo version
- Need to create a new account
- Or clear browser data and start fresh

### Profile Picture Not Showing?
- Web version has limited file system access
- Try using a different browser
- Profile picture feature works best on mobile

---

**Created:** 2025-11-02
**App Version:** 1.0.0 (Stage 1 Complete)
