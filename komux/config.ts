import ponpoko from "./plugins/ponpoko.ts";
export default {
  defaultCwd: "~/work",
  plugins: [ponpoko()],
  env: {
     EDITOR: "hx",
     SSH_AUTH_SOCK: `${process.env.XDG_RUNTIME_DIR ?? "/run/user/1000"}/keyring/ssh`,
     QUOLL_DIR: [
       `${process.env.HOME}/work/exfresso/engineering-log/stories`,
       `${process.env.HOME}/work/exfresso/engineering-log/epics`,
       `${process.env.HOME}/work/exfresso/engineering-log/repos`,
       `${process.env.HOME}/work/qxjit/engineering-log`,
     ].join(":"),
     QUOLL_COMMENT_COMMAND: "komux claude compose --from-stdin --label",
     PONPOKO_CLAUDE: "komux claude --mode auto",
  },
  untrackedCommands: ["claude", "remax", "hx", "q-space", "komux", "quoll"],
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
      labels: { strand: "{project}" },
      jobs: [{ name: "claude", command: ["komux", "claude", "--mode", "auto"], dock: true }],
      drawer: { height: 20 },
      row: [
        { command: ["quoll", "--focus"] },
        { command: ["remax"], focus: true },
      ],
    },
    "story-start": {
      args: ["prompt"],
      labels: { strand: "{project}" },
      jobs: [{ name: "claude", command: ["komux", "claude", "--mode", "auto", "--prompt", "{prompt}"], dock: true }],
      drawer: { height: 20 },
      row: [
        { command: ["quoll", "--focus"] },
        { command: ["remax"], focus: true },
      ],
    },
    dotfiles: {
      jobs: [{ name: "claude", command: ["komux", "claude", "--mode", "auto"], dock: true }],
      drawer: { height: 20 },
      row: [
        { },
        { command: ["remax"], focus: true },
      ],
    },
    "pr-review": {
      args: ["pr", "strand"],
      labels: { strand: "{strand}" },
      name: "{project} #{pr}",
      jobs: [{ name: "claude", command: ["komux", "claude", "--mode", "auto"], dock: true }],
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
