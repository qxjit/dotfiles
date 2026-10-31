export default {
  defaultCwd: "~/work",
  env: {
     EDITOR: "hx",
     SSH_AUTH_SOCK: `${process.env.XDG_RUNTIME_DIR ?? "/run/user/1000"}/ssh-agent.socket`,
     QUOLL_DIR: `${process.env.HOME}/Documents/flipstone-shared/qxjit/notebook`,
     QUOLL_COMMENT_COMMAND: "qmux claude compose --from-stdin --label",
  },
  untrackedCommands: ["claude", "remax", "hx", "q-space", "qmux", "quoll"],
  agentJobs: ["scripts/up", "scripts/nu-up", "scripts/build"],
  projects: {
    roots: ["~/work/*/*","~/work/ptyparty","~/dotfiles"],
    layout: "ide",
    layoutFor: {
      dotfiles: "dotfiles"
    },
  },
  tabs: {
    "*": { layout: "q-space", cwd: "~/work" },
  },
  startup: ["*"],
  layouts: {
    ide: {
      jobs: [{ name: "claude", command: ["qmux", "claude", "--mode", "auto"], dock: true }],
      drawer: { height: 20 },
      row: [
        { command: ["quoll", "--focus"] },
        { command: ["remax"], focus: true },
      ],
    },
    dotfiles: {
      jobs: [{ name: "claude", command: ["qmux", "claude", "--mode", "auto"], dock: true }],
      drawer: { height: 20 },
      row: [
        { },
        { command: ["remax"], focus: true },
      ],
    },
    "pr-review": {
      args: ["pr"],
      name: "{project} #{pr}",
      jobs: [{ name: "claude", command: ["qmux", "claude", "--mode", "auto"], dock: true }],
      drawer: { height: 20 },
      row: [
        { command: ["remax", "--pr", "{pr}"], focus: true },
      ],
    },
    "q-space": {
      jobs: [{ name: "server", command: ["q-space", "serve"] }],
      drawer: { height: 20 },
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
