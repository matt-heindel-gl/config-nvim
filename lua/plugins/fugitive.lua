return {
    {
    'tpope/vim-fugitive',
    cmd = { 'G' },
    keys = {
      { '<leader>gs', ':tab G<CR>', desc = 'status' },
      { '<leader>gb', ':G blame<CR>', desc = 'blame' },
    },
  }
}
