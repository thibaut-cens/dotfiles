function Invoke-Eza {
  param (
      [Parameter(ValueFromRemainingArguments = $true)]
      [string[]]$Args
  )
  eza --icons=always @Args
}

Set-Alias ls Invoke-Eza

