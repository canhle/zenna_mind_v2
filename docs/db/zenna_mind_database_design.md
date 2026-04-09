# Zenna Mind — Database Design
> MVP Version

---

## 1. Collections Overview

```
/sessions                                Master data — meditation sessions
/categories                              Master data — topics/themes
/moods                                   Master data — emotion tags
/users/{uid}                             User profile & settings
/users/{uid}/history/{id}               Completed session history
/users/{uid}/streak/{YYYY-MM}           Monthly streak & stats
/users/{uid}/favorites/{sessionId}      Bookmarked sessions
```

> **Note:** Master data (`sessions`, `categories`, `moods`) is read-only from the app. Write access is restricted via Security Rules.

---

## 2. `/sessions/{sessionId}`

Stores all meditation sessions. This is master data, populated via a seed script.

| Field | Type | Description |
|---|---|---|
| `id` | String | Unique session ID |
| `title` | String | Session name |
| `description` | String | Short description shown on Player screen |
| `categoryId` | String | Reference to `/categories/{categoryId}` |
| `moodIds` | Array | List of mood keys. Reference to `/moods/{moodId}` |
| `duration` | Number | Duration in seconds (600 = 10 min) |
| `level` | String | `beginner` \| `intermediate` \| `advanced` |
| `isGuided` | Boolean | Whether the session has a voice guide |
| `audioUrl` | String | Firebase Storage URL for the audio file |
| `thumbnailUrl` | String | Firebase Storage URL for the thumbnail image |
| `backgroundSound` | String | Sound key: `none` \| `rain` \| `waves` \| `forest` \| `wind` |
| `tags` | Array | Search tags |
| `isFeatured` | Boolean | Show in "Featured" section on Browse screen |
| `isActive` | Boolean | `false` = hidden from app. Never delete — preserves history |
| `order` | Number | Display order within a category |
| `createdAt` | Timestamp | Creation timestamp |

```json
{
  "id":              "session_001",
  "title":           "Peaceful Morning",
  "description":     "Listen to your breath, release tension",
  "categoryId":      "morning",
  "moodIds":         ["calm", "stressed"],
  "duration":        600,
  "level":           "beginner",
  "isGuided":        true,
  "audioUrl":        "gs://zenna-mind.appspot.com/audio/session_001.mp3",
  "thumbnailUrl":    "gs://zenna-mind.appspot.com/thumbnails/session_001.jpg",
  "backgroundSound": "rain",
  "tags":            ["morning", "breathing", "beginner"],
  "isFeatured":      true,
  "isActive":        true,
  "order":           1,
  "createdAt":       "2025-03-01T00:00:00Z"
}
```

> **Note:** `backgroundSound` stores a key (`rain`, `waves`...) not a URL. The app maps keys to URLs via a `SoundMap` constant defined in code.

---

## 3. `/categories/{categoryId}`

Groups sessions by topic. Displayed on the **Topics** tab of the Browse screen.

| Field | Type | Description |
|---|---|---|
| `id` | String | Unique ID: `morning` \| `sleep` \| `focus` \| `relax` \| `stress` |
| `name` | String | Display name |
| `icon` | String | Icon name used in the app |
| `color` | String | Hex color string (data, not design — used for category pills) |
| `order` | Number | Display order |
| `isActive` | Boolean | Toggle visibility without deleting |

```json
{
  "id":       "morning",
  "name":     "Morning",
  "icon":     "sunrise",
  "color":    "#0d6e4a",
  "order":    1,
  "isActive": true
}
```

---

## 4. `/moods/{moodId}`

Tags sessions by emotional state. Displayed on the **Emotions** tab of the Browse screen.

| Field | Type | Description |
|---|---|---|
| `id` | String | Unique ID: `calm` \| `stressed` \| `anxious` \| `sad` \| `tired` \| `happy` |
| `name` | String | Display name |
| `order` | Number | Display order |
| `isActive` | Boolean | Toggle visibility |

```json
{
  "id":       "calm",
  "name":     "Calm",
  "order":    1,
  "isActive": true
}
```

> **Note:** `emoji` and `color` for each mood are defined in the app (`MoodStyles` constant) — not stored in Firestore — to keep design decisions in code.

---

## 5. `/users/{uid}`

User profile. UID comes from Firebase Authentication (including anonymous users).

| Field | Type | Description |
|---|---|---|
| `uid` | String | Firebase Auth UID |
| `isAnonymous` | Boolean | `true` until user links/creates an account |
| `provider` | String | `anonymous` \| `google` \| `apple` \| `email` |
| `email` | String | `null` for anonymous users |
| `displayName` | String | `null` for anonymous users |
| `avatarUrl` | String | `null` for anonymous users |
| `longestStreak` | Number | All-time longest streak (stored here, not in streak doc) |
| `createdAt` | Timestamp | Account creation time |
| `lastActiveAt` | Timestamp | Updated every time the app is opened |
| `settings` | Map | User preferences — see below |

```json
{
  "uid":           "abc123",
  "isAnonymous":   true,
  "provider":      "anonymous",
  "email":         null,
  "displayName":   null,
  "avatarUrl":     null,
  "longestStreak": 0,
  "createdAt":     "2025-03-01T00:00:00Z",
  "lastActiveAt":  "2025-03-08T09:41:00Z",
  "settings": {
    "notificationEnabled": false,
    "notificationTime":    "07:00",
    "defaultDuration":     600,
    "backgroundSound":     "rain"
  }
}
```

> **Note:** Use `linkWithCredential()` when a user signs up to preserve their UID and all associated data.

---

## 6. `/users/{uid}/history/{historyId}`

Logs each completed meditation session.

| Field | Type | Description |
|---|---|---|
| `id` | String | Auto-generated document ID |
| `sessionId` | String | Reference to `/sessions/{sessionId}` |
| `sessionTitle` | String | Denormalized title — avoids a join when displaying history |
| `duration` | Number | Actual time meditated in seconds |
| `mood` | String | Mood the user selected after completing the session |
| `breathCycles` | Number | Number of breath cycles completed |
| `completedAt` | Timestamp | Completion timestamp |

```json
{
  "id":           "hist_001",
  "sessionId":    "session_001",
  "sessionTitle": "Peaceful Morning",
  "duration":     600,
  "mood":         "calm",
  "breathCycles": 7,
  "completedAt":  "2025-03-08T09:51:00Z"
}
```

---

## 7. `/users/{uid}/streak/{YYYY-MM}`

Stores streak and statistics per month. Document ID format: `"2025-03"`.

| Field | Type | Description |
|---|---|---|
| `month` | String | Document ID in `YYYY-MM` format |
| `currentStreak` | Number | Consecutive days meditated up to today. Resets to `0` if a day is missed |
| `totalMinutes` | Number | Total minutes meditated this month. Shown as badge on Streak screen |
| `totalSessions` | Number | Total sessions completed this month |
| `completedDays` | Array | Day numbers in the month when user meditated. Used to render the 7-day calendar |

```json
{
  "month":         "2025-03",
  "currentStreak": 7,
  "totalMinutes":  94,
  "totalSessions": 9,
  "completedDays": [1, 2, 3, 5, 6, 7, 8]
}
```

> **Note:** `currentStreak` can span months. When creating a new month document, check the last day of the previous month in `completedDays` to determine if the streak should continue.

> **Note:** `longestStreak` is stored in `/users/{uid}` — not here — so it always reflects the all-time best regardless of which month it was achieved.

---

## 8. `/users/{uid}/favorites/{sessionId}`

Stores bookmarked sessions. The document ID is the `sessionId` itself.

| Field | Type | Description |
|---|---|---|
| `sessionId` | String | Document ID — reference to `/sessions/{sessionId}` |
| `addedAt` | Timestamp | When the user added this to favorites. Used for sorting |

```json
{
  "sessionId": "session_001",
  "addedAt":   "2025-03-05T10:00:00Z"
}
```

> **Note:** Using `sessionId` as the document ID allows `isFavorited` to be checked with a single `.get()` call instead of a query.

---

## 9. Firestore Security Rules

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {

    // Master data: any authenticated user can read, nobody can write
    match /sessions/{id}   { allow read: if request.auth != null; allow write: if false; }
    match /categories/{id} { allow read: if request.auth != null; allow write: if false; }
    match /moods/{id}      { allow read: if request.auth != null; allow write: if false; }

    // User data: users can only read/write their own documents
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;

      match /history/{id}          { allow read, write: if request.auth.uid == userId; }
      match /streak/{month}        { allow read, write: if request.auth.uid == userId; }
      match /favorites/{sessionId} { allow read, write: if request.auth.uid == userId; }
    }
  }
}
```

---

## 10. Design Notes

| Decision | Rationale |
|---|---|
| Never delete sessions | Set `isActive = false` to hide. Deleting breaks history references. |
| Denormalize `sessionTitle` | Stored in history to avoid a join when displaying the history list. |
| Audio/thumbnail as URLs | Stored as Firebase Storage URLs, not bundled in the app binary. |
| `backgroundSound` as key | App maps key to URL via `SoundMap` constant. Changing the file only requires updating the constant. |
| mood `emoji` & `color` in app | Defined in `MoodStyles` constant, not Firestore. Design decisions belong in code. |
| i18n — not yet | MVP is Vietnamese only. When needed, migrate `name: String` to `name: Map { "vi": ..., "en": ... }` |
| Anonymous Auth | Use `linkWithCredential()` on signup to keep the same UID and preserve all user data. |
| In-progress session | Stored locally with `SharedPreferences`. Firestore is not needed for this use case in MVP. |
| `longestStreak` location | Stored in `/users/{uid}` not in the streak document — it spans multiple months. |
| 2 Firebase projects | `zenna-mind-dev` for dev/staging, `zenna-mind-prod` for production. Each uses its own `serviceAccountKey.json`. |
