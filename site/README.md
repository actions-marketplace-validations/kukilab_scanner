# kukilab.dev

Static site for KukiLab, served as Cloudflare Workers static assets.

- Deployment: Cloudflare **Workers Builds** connected to `github.com/kukilab/scanner`, root directory `site/`, build command — none, deploy command `npx wrangler deploy`.
- Custom domains `kukilab.dev` and `www.kukilab.dev` are declared in `wrangler.jsonc` (`routes` with `custom_domain: true`) and are created on first deploy once the zone is in the same Cloudflare account.
- Fonts are self-hosted (Manrope, Azeret Mono — SIL OFL, licences in `public/fonts/`).
