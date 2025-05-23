return {
  {
    'mhinz/vim-startify',
    lazy = false,
    config = function()
      vim.g.startify_padding_left = 5
      vim.g.startify_relative_path = 1
      vim.g.startify_fortune_use_unicode = 1
      vim.g.startify_change_to_dir = 0
      vim.g.startify_change_to_vcs_root = 1
      vim.g.startify_update_oldfiles = 1
      vim.g.startify_use_env = 1
      vim.g.startify_enable_special = 0
      vim.g.startify_files_number = 10
      vim.g.startify_session_persistence = 1
      vim.g.startify_session_delete_buffers = 1
      vim.g.startify_ascii = {
        ' ',
        ' ϟ ' .. (vim.fn.has('nvim') and 'nvim' or 'vim') .. '.',
        ' ',
      }
      vim.g.startify_custom_header =
        [[map(startify#fortune#boxed() + g:startify_ascii, "repeat(' ', 5).v:val")]]
      vim.g.startify_custom_header_quotes =
        vim.tbl_extend('force', vim.fn['startify#fortune#predefined_quotes'](), {
          {
            'Simplicity is a great virtue but it requires hard work to achieve it',
            'and education to appreciate it. And to make matters worse: complexity',
            'sells better.',
            '',
            '— Edsger W. Dijkstra',
          },
          {
            'A common fallacy is to assume authors of incomprehensible code will',
            'be able to express themselves clearly in comments.',
          },
          {
            'Your time is limited, so don’t waste it living someone else’s life.',
            'Don’t be trapped by dogma — which is living with the results of other',
            'people’s thinking. Don’t let the noise of others’ opinions drown out',
            'your own inner voice. And most important, have the courage to follow',
            'your heart and intuition. They somehow already know what you truly ',
            'want to become. Everything else is secondary.',
            '',
            '— Steve Jobs, June 12, 2005',
          },
          {
            'My take: Animations are something you earn the right to include',
            'when the rest of the experience is fast and intuitive.',
            '',
            '— @jordwalke',
          },
          {
            'If a feature is sometimes dangerous, and there is a better option',
            'then always use the better option.',
            '',
            '- Douglas Crockford',
          },
          {
            'The best way to make your dreams come true is to wake up.',
            '',
            '— Paul Valéry',
          },
          {
            'Fast is slow, but continuously, without interruptions',
            '',
            '– Japanese proverb',
          },
          {
            'A language that doesn’t affect the way you think about programming',
            'is not worth knowing.',
            '- Alan Perlis',
          },
          {
            'Bad programmers worry about the code. Good programmers worry about',
            'data structures and their relationships',
            '',
            '— Linus Torvalds',
          },
          {
            'Work expands to fill the time available for its completion.',
            '',
            "— C. Northcote Parkinson (Parkinson's Law)",
          },
          {
            'Hard Choices, Easy Life. Easy Choices, Hard Life.',
            '',
            '— Jerzy Gregory',
          },
          {
            'Future regret minimization is a powerful force for good judgement.',
            '',
            '— Tobi Lutke',
          },
          {
            'The works must be conceived with fire in the soul but executed with',
            'clinical coolness',
            '',
            '— Joan Miró',
          },
          {
            'Believe those who seek the truth, doubt those who find it.',
            '',
            '— André Gide',
          },
          {
            "Argue like you're right. Listen like you're wrong",
            '',
            '— Adam M. Grant',
          },
          {
            'Luck is what happens when preparation meets opportunity.',
            '',
            '— Seneca',
          },
          {
            'A complex system that works is invariably found to have evolved from',
            'a simple system that worked. The inverse proposition also appears to',
            'be true: A complex system designed from scratch never works and',
            'cannot be made to work. You have to start over, beginning with a',
            'working simple system.',
            '',
            '— John Gall',
          },
          {
            'I think that large objected-oriented programs struggle with',
            'increasing complexity as you build this large object graph of mutable',
            'objects. You know, trying to understand and keep in your mind what',
            'will happen when you call a method and what will the side effects be.',
            '',
            '— Rich Hickey',
          },
          {
            'Most people overestimate what they can do in one year and',
            'underestimate what they can do in ten years',
            '',
            '— Bill Gates',
          },
          {
            'Compound interest is the eighth wonder of the world. He who',
            'understands it, earns it. He who doesn’t, pays it.',
            '',
            '— Albert Einstein',
          },
          { 'Time is the fire in which we burn', '', '— Delmore Schwartz' },
          {
            'A ship in harbor is safe, but that is not what ships are built for.',
            '— John A. Shedd',
          },
          {
            'You can’t call yourself a leader by coming into a situation that',
            'is by nature uncertain, ambiguous — and create confusion.',
            'You have to create clarity where none exists',
            '— Satya Nadella',
          },
          {
            'The competent programmer is fully aware of the strictly limited',
            'size of his own skull; therefore he approaches the programming',
            'task in full humility',
            '— Edsger W. Dijkstra',
          },
          {
            'Yeah I know how to make packages, build system and other stuff.',
            'But I don’t want. It’s easy unthankful work with unpredictable',
            'audience reaction',
            '— Max G',
          },
          {
            'A well-designed system makes it easy to do the right things and',
            'annoying (but not impossible) to do the wrong things',
            '',
            '— Jeff Atwood',
          },
        })

      vim.g.startify_bookmarks = {
        { t = '.git/todo.md' },
        { g = '~/.gitconfig' },
        { i = '~/.gitignore' },
        { r = '~/.taskrc' },
      }

      vim.g.startify_commands = {
        { s = { 'Lazy Sync', ':Lazy sync' } },
        { u = { 'Lazy Update', ':Lazy update' } },
        { c = { 'Lazy Clean', ':Lazy clean' } },
        { t = { "Treesitter Update", ":TSUpdate" } },
        { h = { "Check Health", ":checkhealth" } }
      }

      vim.g.startify_lists = {
        { header = { ' Sessions' }, type = 'sessions' },
        {
          header = {
            ' MRU [' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':~') .. ']',
          },
          type = 'dir',
        },
        -- { header = { ' Files' }, type = 'files' },
        { header = { ' Commands' }, type = 'commands' },
        { header = { ' Bookmarks' }, type = 'bookmarks' },
      }

      vim.g.startify_skiplist = {
        'COMMIT_EDITMSG',
        '^/tmp',
        vim.fn.escape(
          vim.fn.fnamemodify(vim.fn.resolve(vim.env.VIMRUNTIME), ':p'),
          '\\'
        ) .. 'doc',
        'plugged/.*/doc',
        'pack/.*/doc',
        '.*/vimwiki/.*',
        'node_modules',
      }

    end,
    lazy = false,
  },
}
