﻿<#############################################################################
The DebugPx module provides a set of commands that make it easier to debug
PowerShell scripts, functions and modules. These commands leverage the native
debugging capabilities in PowerShell (the callstack, breakpoints, error output
and the -Debug common parameter) and provide additional functionality that
these features do not provide, enabling a richer debugging experience.

Copyright © 2014 Kirk Munro.

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License in the
license folder that is included in the DebugPx module. If not, see
<https://www.gnu.org/licenses/gpl.html>.
#############################################################################>

<#
.SYNOPSIS
    Disables the breakpoint command.
.DESCRIPTION
    The Disable-BreakpointCommand command disables the breakpoint command in your PowerShell environment.
.PARAMETER WhatIf
    Shows what would happen if the command was run unrestricted. The command is run, but any changes it would make are prevented, and text descriptions of those changes are written to the console instead.
.PARAMETER Confirm
    Prompts you for confirmation before any system changes are made using the command.
.INPUTS
    None
.OUTPUTS
    None
.NOTES
    When the breakpoint command is enabled, invoking breakpoint, bp, or Suspend-Execution may result in a script that is running stopping on a breakpoint on that line. For more information, invoke Get-Help breakpoint.
.EXAMPLE
    PS C:\> Disable-BreakpointCommand
    PS C:\> Get-Service w* | breakpoint {$_.Name -eq 'wuauserv'} | Select-Object -ExpandProperty Name

    The first command disables the breakpoint command. When the next command is invoked, the services are output in the console and the breakpoint is skipped entirely.
.EXAMPLE
    PS C:\> Disable-BreakpointCommand
    PS C:\> & {'Before breakpoint'; breakpoint; 'After breakpoint'}

    The first command disables the breakpoint command. When the next command is invoked, the string "Before breakpoint" will be output to the console, and then the string "After breakpoint" will be output to the console. The breakpoint command does nothing in this scenario.
.LINK
    Enable-BreakpointCommand
.LINK
    breakpoint
#>
function Disable-BreakpointCommand {
    [CmdletBinding(SupportsShouldProcess=$true)]
    [OutputType([System.Void])]
    param()
    try {
        #region Disable the breakpoint command breakpoint.

        Disable-PSBreakpoint -Breakpoint $script:Breakpoint.Command

        #endregion
    } catch {
        $PSCmdlet.ThrowTerminatingError($_)
    }
}

Export-ModuleMember -Function Disable-BreakpointCommand

if (-not (Get-Alias -Name dbpc -ErrorAction Ignore)) {
    New-Alias -Name dbpc -Value Disable-BreakpointCommand
    Export-ModuleMember -Alias dbpc
}