export default {
  defaultCwd: "~/work",
  env: {
     EDITOR: "hx",
     SSH_AUTH_SOCK: `${process.env.XDG_RUNTIME_DIR ?? "/run/user/1000"}/keyring/ssh`,
  },
  untrackedCommands: ["claude", "remax", "hx", "q-space", "qmux"],
  agentJobs: ["scripts/up", "scripts/nu-up", "scripts/build"],
  projects: {
    roots: ["~/work/*/*"],
    layout: "ide",
    layoutFor: { },
  },
  tabs: {
    "*": { layout: "q-space", cwd: "~/work" },
  },
  startup: ["*"],
  layouts: {
    ide: {
      jobs: [{ name: "claude", command: ["qmux", "claude"], dock: true }],
      row: [
        { command: ["remax"], focus: true },
        {},
      ],
    },
    "q-space": {
      jobs: [{ name: "server", command: ["q-space", "serve"] }],
      row: [
        { command: ["q-space", "pane", "stories" ], focus: true },
        { column: [
          { command: ["q-space", "pane", "reviews"] },
          { command: ["q-space", "pane", "mentions"] },
        ]},
      ],
    },
  },
};
