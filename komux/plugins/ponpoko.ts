const command = ["/home/qxjit/.bun/bin/bun","/home/qxjit/work/ptyparty/ponpoko/src/cli.ts"];

export type PonpokoOptions = { deal?: string; catchUp?: string; leader?: string };

export default function ponpoko(options: PonpokoOptions = {}) {
  const deal = { popup: [...command, "deal"], name: "your move", width: 95, height: 75 };
  const catchUp = { popup: [...command, "deal", "--unseen"], name: "catch up", width: 95, height: 75 };
  const thisTab = { popup: [...command, "deal", "--tab"], name: "this tab", width: 95, height: 75 };
  return {
    name: "ponpoko",
    run: [[...command, "komux"]],
    tray: [{ name: "ponpoko", stream: [...command, "tray", "--stream"], open: command }],
    keys: [
      { key: options.deal ?? "alt+m", ...deal },
      { key: options.catchUp ?? "alt+shift+m", ...catchUp },
    ],
    modes: [
      {
        key: options.leader ?? "m",
        name: "ponpoko",
        about: "whose move",
        keys: [
          { key: "m", ...deal },
          { key: "shift+m", ...catchUp },
          { key: "t", ...thisTab },
          { key: "o", popup: command, name: "overview" },
          { key: "l", popup: [...command, "log"], name: "log", width: 90, height: 75 },
        ],
      },
    ],
  };
}
