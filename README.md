# f02 — Version Control

Companion repository for the **[f02 — Version Control](https://thecodingidiot.com/chapters/f02-version-control)** chapter on [thecodingidiot.com](https://thecodingidiot.com).

---

## Run the tester

The tester checks your `f02-practice` git history, so it must run from
inside that directory:

```bash
git clone https://github.com/thecodingidiot-com/f02-version-control.git
cp f02-version-control/test.sh ~/f02-practice/
cd ~/f02-practice
bash test.sh
```

```text
bash test.sh          run all checks
bash test.sh --help   full usage
```

---

## What the tester checks

1. At least five commits exist on the main branch.
2. A branch was created and merged back — a merge commit is present in the log.
3. No unresolved conflict markers (`<<<<<<<`, `>>>>>>>`) appear in any tracked file.
4. A remote named `origin` is configured.

The Perfect Dark clone step is self-certified. The tester cannot verify
what you saw when you read someone else's repository history.

---

## License

[MIT License](LICENSE) — the tester code is free to read, modify, and redistribute.
