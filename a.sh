#!/bin/bash

# Hyprland keybindings help
# TODO: move this function into zsh.nix shellInit
function hypr() {
	local BOLD="\e[1m"
	local RESET="\e[0m"
	local CYAN="\e[36m"
	local YELLOW="\e[33m"
	local DIM="\e[2m"

	echo ""
	echo -e "${BOLD}${CYAN}╔══════════════════════════════════════════════════════╗${RESET}"
	echo -e "${BOLD}${CYAN}║           Hyprland Keybindings Cheatsheet            ║${RESET}"
	echo -e "${BOLD}${CYAN}╚══════════════════════════════════════════════════════╝${RESET}"

	# ── Window Management ────────────────────────────────────────
	echo ""
	echo -e "${BOLD}${YELLOW}  Window Management${RESET}"
	echo -e "${DIM}  ──────────────────────────────────────────────────────${RESET}"
	echo ""
	printf "  ${BOLD}%-24s${RESET} %s\n" "Super + Q" "Close active window"
	printf "  ${BOLD}%-24s${RESET} %s\n" "Super + M" "Exit Hyprland (logout)"
	printf "  ${BOLD}%-24s${RESET} %s\n" "Super + F" "Toggle fullscreen"
	printf "  ${BOLD}%-24s${RESET} %s\n" "Super + T" "Toggle floating mode"

	# ── Applications ─────────────────────────────────────────────
	echo ""
	echo -e "${BOLD}${YELLOW}  Applications${RESET}"
	echo -e "${DIM}  ──────────────────────────────────────────────────────${RESET}"
	echo ""
	printf "  ${BOLD}%-24s${RESET} %s\n" "Super + Enter" "Open terminal (ghostty)"
	printf "  ${BOLD}%-24s${RESET} %s\n" "Super + B" "Open browser (firefox)"
	printf "  ${BOLD}%-24s${RESET} %s\n" "Super + E" "Open file manager (dolphin)"
	printf "  ${BOLD}%-24s${RESET} %s\n" "Super + D" "Open Discord"

	# ── Launcher & Utilities ─────────────────────────────────────
	echo ""
	echo -e "${BOLD}${YELLOW}  Launcher & Utilities${RESET}"
	echo -e "${DIM}  ──────────────────────────────────────────────────────${RESET}"
	echo ""
	printf "  ${BOLD}%-24s${RESET} %s\n" "Super + Space" "App launcher (rofi)"
	printf "  ${BOLD}%-24s${RESET} %s\n" "Super + Tab" "Window switcher (rofi)"
	printf "  ${BOLD}%-24s${RESET} %s\n" "Super + V" "Clipboard history (cliphist + rofi)"
	printf "  ${BOLD}%-24s${RESET} %s\n" "Super + C" "Color picker (hyprpicker, copies to clipboard)"

	# ── Focus Movement ───────────────────────────────────────────
	echo ""
	echo -e "${BOLD}${YELLOW}  Focus Movement  ${DIM}(vim-style hjkl)${RESET}"
	echo -e "${DIM}  ──────────────────────────────────────────────────────${RESET}"
	echo ""
	printf "  ${BOLD}%-24s${RESET} %s\n" "Super + H" "Focus left"
	printf "  ${BOLD}%-24s${RESET} %s\n" "Super + L" "Focus right"
	printf "  ${BOLD}%-24s${RESET} %s\n" "Super + K" "Focus up"
	printf "  ${BOLD}%-24s${RESET} %s\n" "Super + J" "Focus down"

	# ── Window Movement ──────────────────────────────────────────
	echo ""
	echo -e "${BOLD}${YELLOW}  Window Movement  ${DIM}(vim-style hjkl)${RESET}"
	echo -e "${DIM}  ──────────────────────────────────────────────────────${RESET}"
	echo ""
	printf "  ${BOLD}%-24s${RESET} %s\n" "Super + Shift + H" "Move window left"
	printf "  ${BOLD}%-24s${RESET} %s\n" "Super + Shift + L" "Move window right"
	printf "  ${BOLD}%-24s${RESET} %s\n" "Super + Shift + K" "Move window up"
	printf "  ${BOLD}%-24s${RESET} %s\n" "Super + Shift + J" "Move window down"

	# ── Workspaces ───────────────────────────────────────────────
	echo ""
	echo -e "${BOLD}${YELLOW}  Workspaces${RESET}"
	echo -e "${DIM}  ──────────────────────────────────────────────────────${RESET}"
	echo ""
	printf "  ${BOLD}%-24s${RESET} %s\n" "Super + 1–9" "Switch to workspace 1–9"
	printf "  ${BOLD}%-24s${RESET} %s\n" "Super + 0" "Switch to workspace 10"
	printf "  ${BOLD}%-24s${RESET} %s\n" "Super + Shift + 1–9" "Move window to workspace 1–9"
	printf "  ${BOLD}%-24s${RESET} %s\n" "Super + Shift + 0" "Move window to workspace 10"

	# ── Screenshots ──────────────────────────────────────────────
	echo ""
	echo -e "${BOLD}${YELLOW}  Screenshots  ${DIM}(grimblast)${RESET}"
	echo -e "${DIM}  ──────────────────────────────────────────────────────${RESET}"
	echo ""
	printf "  ${BOLD}%-24s${RESET} %s\n" "Print" "Copy selected area to clipboard"
	printf "  ${BOLD}%-24s${RESET} %s\n" "Super + Print" "Copy + save area to ~/Pictures/Screenshots/"

	# ── Volume & Brightness ──────────────────────────────────────
	echo ""
	echo -e "${BOLD}${YELLOW}  Volume & Brightness  ${DIM}(hold to repeat)${RESET}"
	echo -e "${DIM}  ──────────────────────────────────────────────────────${RESET}"
	echo ""
	printf "  ${BOLD}%-24s${RESET} %s\n" "XF86AudioRaiseVolume" "Speaker volume +5%"
	printf "  ${BOLD}%-24s${RESET} %s\n" "XF86AudioLowerVolume" "Speaker volume -5%"
	printf "  ${BOLD}%-24s${RESET} %s\n" "Shift + XF86AudioRaiseVol" "Microphone volume +5%"
	printf "  ${BOLD}%-24s${RESET} %s\n" "Shift + XF86AudioLowerVol" "Microphone volume -5%"
	printf "  ${BOLD}%-24s${RESET} %s\n" "XF86AudioMute" "Toggle speaker mute (works on lock screen)"
	printf "  ${BOLD}%-24s${RESET} %s\n" "XF86AudioMicMute" "Toggle mic mute (works on lock screen)"
	printf "  ${BOLD}%-24s${RESET} %s\n" "XF86MonBrightnessUp" "Brightness +5%"
	printf "  ${BOLD}%-24s${RESET} %s\n" "XF86MonBrightnessDown" "Brightness -5%"

	# ── Mouse ────────────────────────────────────────────────────
	echo ""
	echo -e "${BOLD}${YELLOW}  Mouse Bindings${RESET}"
	echo -e "${DIM}  ──────────────────────────────────────────────────────${RESET}"
	echo ""
	printf "  ${BOLD}%-24s${RESET} %s\n" "Super + Left drag" "Move window"
	printf "  ${BOLD}%-24s${RESET} %s\n" "Super + Right drag" "Resize window"
	echo -e "  ${DIM}  Dragging borders/gaps also resizes (resize_on_border = true)${RESET}"
	echo ""
}

hypr
