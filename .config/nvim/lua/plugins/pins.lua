-- Pin all LazyVim-bundled plugins to the exact commits recorded in lazy-lock.json.
-- Only the commit field is set here; all other configuration comes from LazyVim defaults.
return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    commit = "2b7da97d655416462d4d5c38d0eb1f1eacc900a2",
  }, -- latest: v4.7.4
  {
    "b0o/SchemaStore.nvim",
    commit = "624384c0e0671db9ee8cd23e2678840e84335903",
  },
  {
    "fang2hou/blink-copilot",
    commit = "7ad8209b2f880a2840c94cdcd80ab4dc511d4f39",
  }, -- latest: v1.4.1
  {
    "Saghen/blink.cmp",
    branch = "v1",
    commit = "e0d51adba95174760e2e1454fe39543d96194118",
  }, -- latest: v1.10.2
  {
    "akinsho/bufferline.nvim",
    commit = "655133c3b4c3e5e05ec549b9f8cc2894ac6f51b3",
  }, -- latest: v4.9.1
  {
    "catppuccin/nvim",
    name = "catppuccin",
    commit = "edefef779ab08ce1a4a404713e3012b0d202bd35",
  }, -- latest: v2.0.0
  {
    "p00f/clangd_extensions.nvim",
    commit = "78c2ecd659d54972be17aa6ba2deac3c53223b80",
  },
  {
    "Civitasv/cmake-tools.nvim",
    commit = "782a254c62a61af1d4febddd0d6dbc5ea414a027",
  },
  { "monaqa/dial.nvim", commit = "f2634758455cfa52a8acea6f142dcd6271a1bf57" }, -- latest: v0.5.1
  {
    "stevearc/dressing.nvim",
    commit = "2d7c2db2507fa3c4956142ee607431ddb2828639",
  }, -- latest: v3.1.1
  {
    "rafamadriz/friendly-snippets",
    commit = "7a1c9f7897a4eb078b157a04c7af81e5869215b1",
  },
  {
    "lewis6991/gitsigns.nvim",
    commit = "ea38d317af34f8ffcfbaf0f0dcc1471736661a4c",
  }, -- latest: v2.1.0
  {
    "MagicDuck/grug-far.nvim",
    commit = "91b7e58b6ffc6ddad5acb7a7c1df21257724449e",
  },
  {
    "qvalentin/helm-ls.nvim",
    commit = "20df43509b02a3ce3c6b3eee254d6e2bffa9a370",
  },
  { "folke/lazydev.nvim", commit = "ff2cbcba459b637ec3fd165a2be59b7bbaeedf0d" }, -- latest: v1.10.0
  {
    "nvim-lualine/lualine.nvim",
    commit = "221ce6b2d999187044529f49da6554a92f740a96",
  },
  {
    "iamcco/markdown-preview.nvim",
    commit = "a923f5fc5ba36a3b17e289dc35dc17f66d0548ee",
  }, -- latest: v0.0.10
  {
    "mason-org/mason-lspconfig.nvim",
    commit = "761d376b5fbe6b21f659432ffadc1205c660176c",
  }, -- latest: v2.3.0
  {
    "mason-org/mason.nvim",
    commit = "2a6940af80375532e5e9e7c1f2fc6319a1b7a69d",
  }, -- latest: v2.3.1
  { "nvim-mini/mini.ai", commit = "813d10a43d5d4eda4816e6a27eb6bf6250f75ea8" },
  {
    "nvim-mini/mini.icons",
    commit = "5d58117d176c133f4cb5585ec8cb3450881c89a0",
  },
  {
    "nvim-mini/mini.pairs",
    commit = "e332261859814c307e72458222070f84b6d6f4e8",
  },
  { "folke/noice.nvim", commit = "7bfd942445fb63089b59f97ca487d605e715f155" }, -- latest: v4.10.0
  {
    "MunifTanjim/nui.nvim",
    commit = "10fc361835c856ba4233ef5ea135b919bf3dce97",
  }, -- latest: 0.4.0
  {
    "mfussenegger/nvim-ansible",
    commit = "c7f595d568b588942d4d0c37b5cd6cae3764a148",
  },
  {
    "mfussenegger/nvim-lint",
    commit = "6bf29b9dbdad60b38b489b23309c22ba6d4c915a",
  },
  {
    "neovim/nvim-lspconfig",
    commit = "7d22e678970d95d8d18494ec389c52b07111c53a",
  }, -- latest: v2.13.0
  {
    "nvim-treesitter/nvim-treesitter",
    commit = "52773f0d13a0c11d0c3ef33c14ab6ecc1c17148b",
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    commit = "5c7b0263797dfd1bd6202f2b219f3b53a80b2187",
  },
  {
    "windwp/nvim-ts-autotag",
    commit = "d7220b55e16ed3c04e88086256def5d282429493",
  },
  {
    "folke/persistence.nvim",
    commit = "b20b2a7887bd39c1a356980b45e03250f3dce49c",
  }, -- latest: v3.1.0
  {
    "nvim-lua/plenary.nvim",
    commit = "74b06c6c75e4eeb3108ec01852001636d85a932b",
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    commit = "a67f826164c38c836fc6060f32b275c4c43317a7",
  }, -- latest: v8.14.0
  { "folke/snacks.nvim", commit = "882c996cf28183f4d63640de0b4c02ec886d01f2" }, -- latest: v2.31.0
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    commit = "b25b749b9db64d375d782094e2b9dce53ad53a40",
  },
  {
    "ANGkeith/telescope-terraform-doc.nvim",
    commit = "66987fac94d12704fdfd90b857f4f648e31251c9",
  },
  {
    "cappyzawa/telescope-terraform.nvim",
    commit = "072c97023797ca1a874668aaa6ae0b74425335df",
  },
  {
    "nvim-telescope/telescope.nvim",
    commit = "1e1bab730218eaf97fce743be3f56e51075928ac",
  }, -- latest: v0.2.2
  {
    "folke/todo-comments.nvim",
    commit = "31e3c38ce9b29781e4422fc0322eb0a21f4e8668",
  }, -- latest: v1.5.0
  {
    "folke/tokyonight.nvim",
    commit = "cdc07ac78467a233fd62c493de29a17e0cf2b2b6",
  }, -- latest: v4.14.1
  { "folke/trouble.nvim", commit = "bd67efe408d4816e25e8491cc5ad4088e708a69a" }, -- latest: v3.7.1
  {
    "folke/ts-comments.nvim",
    commit = "a59d6092213447450191122c9346f309161504cb",
  }, -- latest: v1.5.0
  {
    "linux-cultist/venv-selector.nvim",
    commit = "cc4bb3975de8835291f9bb45889e96c6b2795fc4",
  },
  { "tpope/vim-dadbod", commit = "6d1d41da4873a445c5605f2005ad2c68c99d8770" },
  {
    "kristijanhusak/vim-dadbod-completion",
    commit = "8c65c6b02e8434e5360fc78097e489c05e899697",
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    commit = "afd07819d8efcefc3317205b855ad4e3513b0011",
  },
  {
    "folke/which-key.nvim",
    commit = "3aab2147e74890957785941f0c1ad87d0a44c15a",
  }, -- latest: v3.17.0
  { "gbprod/yanky.nvim", commit = "edcbe0f6d693b9e7860626094f886a2d79cfe63b" }, -- latest: v2.0.0
}
