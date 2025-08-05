# Wine Access Control System 🍷🔐

Lock up your Wine like a boss — this lil’ utility lets you **shut off Wine for non-root users**, or temporarily let `.exe` files party for a bit.

---

## 💡 What This Does

This setup gives you a toggle switch to:
- Stop Wine from launching shady `.exe` files
- Keep Wine exclusive to root users
- Temporarily allow Wine access (e.g., just for 60 seconds)

For devs who use Wine for stuff like Electron builds — but don’t trust random `.exe` files floating around.

---

## ⚙️ How It Works

It flips the execute permissions on:

- `/usr/bin/wine`
- `/usr/bin/wine64`

| Mode     | Permissions        | Who Can Run |
|----------|--------------------|--------------|
| Locked   | `-rwx------`       | Only root   |
| Unlocked | `-rwxr-xr-x`       | Anyone      |

Basically: if it ain’t root, it ain’t running `.exe`.

---

## 📁 What’s Inside

| File                      | Description                            |
|---------------------------|----------------------------------------|
| `/usr/local/bin/wine`     | Main command — accepts `lock`, `unlock`, etc. |
| `/usr/local/bin/wine-lock`| Actually locks Wine binaries           |
| `/usr/local/bin/wine-unlock` | Unlocks Wine (with optional timer) |

---

## 🚀 Installation

Clone and go:

```bash
git clone https://github.com/theamanullahdev/wine-locker.git
cd wine-locker
sudo ./install.sh
```

This will:
- Copy the scripts to `/usr/local/bin/`
- Strip the `.sh` extensions
- Set everything up as root-owned + executable

Done. You’re ready to roll.

---

## 🧠 Commands

```bash
wine lock
```
 Locks Wine — no `.exe` files can run unless you're root

```bash
wine unlock
```
 Unlocks Wine so anyone can use it

```bash
wine unlock 60
```
 Temporarily unlocks Wine for 60 seconds, then auto-locks like a ninja

```bash
wine stats
```
 Shows whether Wine is locked or not

---

## 🕵️ Verify It

Wanna peek behind the curtain? Use this:

```bash
ls -l /usr/local/bin/wine*
ls -l "$(readlink -f /usr/bin/wine)" "$(readlink -f /usr/bin/wine64 2>/dev/null)" 2>/dev/null
```

---

## 🧐 What the Output Means

| Output           | Meaning                        |
|------------------|--------------------------------|
| `-rwx------`     | Locked — only root can run Wine |
| `-rwxr-xr-x`     | Unlocked — everyone can run it  |
| Something else   | Bro check your perms, this ain’t it 🔍

---

## 🧱 Why This Exists

Let’s be real:  
Uninstalling/reinstalling Wine to “disable” it? That’s goofy.  
This tool just lets you **toggle it cleanly** with one command.

---

## 💾 Persistence

- Lock state survives reboots
- No `sudo` needed to lock or check stats
- `sudo` is required only for unlocking

Set it once, forget it — until you need it again.

---

## 📄 License

Licensed under [GNU GPLv3](LICENSE)  
© 2025 [theamanullahdev](https://github.com/theamanullahdev)

---

## 🤙 Pro Tip

You can use this like a power switch:

- `wine lock` → done for the day
- `wine unlock 60` → just need it for a sec
- `wine stats` → curious if you left the door open?

---

Stay safe out there. `.exe` files don’t love you back.
(I might update stats thingy later, but it works for now for me, I was just annouyed to uninstall wine after each electron build for exe. So built this simple tool)
