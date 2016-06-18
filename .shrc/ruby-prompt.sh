__rbenv_ps1 ()
{
  printf `rbenv version | sed -e 's/ .*//'`
}
