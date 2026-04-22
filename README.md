# f02 — Version Control

Companion repository for the **[f02 — Version Control](https://thecodingidiot.com/chapters/f02-version-control)** chapter on [thecodingidiot.com](https://thecodingidiot.com).

---

## Follow my journey

You are working through the implementation pages. Copy the tester into your `f02-practice` repository and run it from there when you have finished.

```bash
git clone https://github.com/thecodingidiot-com/f02-version-control.git
cp f02-version-control/test.sh ~/f02-practice/
cd ~/f02-practice
bash test.sh
```

Use `bash test.sh --help` to see what each check verifies.

---

## Follow your journey

You built it independently. Copy the tester into your repository and run it to check your solution against the project brief:

```bash
git clone https://github.com/thecodingidiot-com/f02-version-control.git
cp f02-version-control/test.sh ~/f02-practice/
cd ~/f02-practice
bash test.sh
```

The tester prints `PASS` or `FAIL` with a short explanation for each check.

---

## What the tester checks

1. At least five commits exist on the main branch.
2. A branch was created and merged back — a merge commit is present in the log.
3. No unresolved conflict markers (`<<<<<<<`, `>>>>>>>`) appear in any tracked file.
4. A remote named `origin` is configured.

The SM64 clone step is self-certified. The tester cannot verify what you saw when you read someone else's repository history.

---

## License

[GPLv2](LICENSE) — the tester code is free to read, modify, and redistribute under the same terms.
