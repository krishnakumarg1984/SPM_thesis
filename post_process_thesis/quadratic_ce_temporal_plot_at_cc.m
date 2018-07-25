% Copyright (c) 2018 Gopalakrishnan, Krishnakumar <krishnak@vt.edu>
% Author: Gopalakrishnan, Krishnakumar <krishnak@vt.edu>

% clear;clc; format short g; format compact; close all;
golden_ratio = 1.618;

fig_width_factor = 1;
ax_width_factor = 0.725;
fig_ht_factor = 0.75;

figW_cm = 15.74776*fig_width_factor;     % textwidth (cm) reported by LaTeX doc with a scaling factor
figH_cm = figW_cm/golden_ratio;

n_axes_w = 2; % how many horizontal/width-wise axes?
n_axes_ht = 2;  % how many vertical axes?

ax_width = (figW_cm/n_axes_w)*ax_width_factor;
ax_height = ax_width/golden_ratio;

% decision
% left_margin : gap_w : right_margin
gap_w_scale = 1.2;         % wrt to marg_w_left
marg_w_right_scale = 0.3;   % wrt to marg_w_left

% bottom_margin : gap_ht : top_margin
gap_ht_scale = 0.9375;        % wrt to marg_ht_bottom
marg_ht_top_scale = 0.3;     % wrt to marg_ht_bottom

%%
marg_w_left = (figW_cm - n_axes_w*ax_width)/(1 + gap_w_scale + marg_w_right_scale);
gap_w = marg_w_left*gap_w_scale;
marg_w_right = marg_w_left*marg_w_right_scale;

marg_ht_bottom = (figH_cm - n_axes_ht*ax_height)/(1 + gap_ht_scale + marg_ht_top_scale);
gap_ht = marg_ht_bottom*gap_ht_scale;
marg_ht_top = marg_ht_bottom*marg_ht_top_scale;

run('setup_line_colors.m'); % deletes axes/clears plots
cbrewerintergray = [189,189,189]/255;
cbrewerdarkgray = [99,99,99]/255;
[ha, pos] = tight_subplot_cm(n_axes_ht, n_axes_w, [gap_ht gap_w],[marg_ht_bottom marg_ht_top],[marg_w_left marg_w_right],figH_cm,figW_cm);

%% Post-process and plot
no_of_x_tick_points = 5;
no_of_y_tick_points = 5;
t_common = 0:Ts:t_end_common;
t_end_max = max(quadratic_ce_sim_time_vector(end),time_vector_p2d(end));
t_end_max_order = floor(log10(t_end_max));
t_end_max_plot = ceil((t_end_max/10^t_end_max_order)/0.5)*0.5*10^t_end_max_order;


clc;

axes(ha(1));
plot(time_vector_p2d,ce_neg_p2d_newconvention(:,1),'color',line_colors(2,:)); 
hold on;
plot(quadratic_ce_sim_time_vector,ce_neg_cc_quadratic,'color',line_colors(1,:));
hold off;
ylabel('$c_{\mathrm{e}}(0,t)\  (\mathrm{mol\, m}^{-3})$');
lgd = legend('P2d','Quadratic','location','northwest');
legend boxoff;
xlim([0 t_end_max_plot]);
ax_handle = gca;
ax_handle.YAxis.TickValues = linspace(ax_handle.YAxis.Limits(1),ax_handle.YAxis.Limits(2),no_of_y_tick_points); % not for voltage
ax_handle.XAxis.TickValues = linspace(ax_handle.XAxis.Limits(1),ax_handle.XAxis.Limits(2),no_of_x_tick_points);
curtick = get(gca, 'XTick');
set(gca, 'XTickLabel', cellstr(num2str(curtick(:)))); % remove scientific multipliers in x-axis format

axes(ha(2));
plot(time_vector_p2d,ce_pos_p2d_newconvention(:,end),'color',line_colors(2,:)); 
hold on;
plot(quadratic_ce_sim_time_vector,ce_pos_cc_quadratic,'color',line_colors(1,:));
hold off;
ylabel('$c_\mathrm{e}(l_\mathrm{tot},t)\ (\mathrm{mol\, m}^{-3})$');
lgd = legend('P2d','Quadratic','location','northwest');
legend boxoff;
xlim([0 t_end_max_plot]);
ax_handle = gca;
ax_handle.YAxis.TickValues = linspace(ax_handle.YAxis.Limits(1),ax_handle.YAxis.Limits(2),no_of_y_tick_points); % not for voltage
ax_handle.XAxis.TickValues = linspace(ax_handle.XAxis.Limits(1),ax_handle.XAxis.Limits(2),no_of_x_tick_points);
curtick = get(gca, 'XTick');
set(gca, 'XTickLabel', cellstr(num2str(curtick(:)))); % remove scientific multipliers in x-axis format

axes(ha(3));
plot(t_common,ce_neg_p2d_newconvention(1:length(t_common),1) - ce_neg_cc_quadratic(1:length(t_common))','color',cbrewerdarkgray); 
ylabel('$\varepsilon_{c_{\mathrm{e,negcc}}} (\mathrm{mol\, m}^{-3})$');
xlim([0 t_end_max_plot]);
ax_handle = gca;
ax_handle.YAxis.TickValues = linspace(ax_handle.YAxis.Limits(1),ax_handle.YAxis.Limits(2),no_of_y_tick_points); % not for voltage
ax_handle.XAxis.TickValues = linspace(ax_handle.XAxis.Limits(1),ax_handle.XAxis.Limits(2),no_of_x_tick_points);
curtick = get(gca, 'XTick');
set(gca, 'XTickLabel', cellstr(num2str(curtick(:)))); % remove scientific multipliers in x-axis format
xlabel('time (s)');

axes(ha(4));
plot(t_common,ce_pos_p2d_newconvention(1:length(t_common),end) - ce_pos_cc_quadratic(1:length(t_common))','color',cbrewerdarkgray); 
ylabel('$\varepsilon_{c_{\mathrm{e,poscc}}} (\mathrm{mol\, m}^{-3})$');
xlim([0 t_end_max_plot]);
ax_handle = gca;
ax_handle.YAxis.TickValues = linspace(ax_handle.YAxis.Limits(1),ax_handle.YAxis.Limits(2),no_of_y_tick_points); % not for voltage
ax_handle.XAxis.TickValues = linspace(ax_handle.XAxis.Limits(1),ax_handle.XAxis.Limits(2),no_of_x_tick_points);
curtick = get(gca, 'XTick');
set(gca, 'XTickLabel', cellstr(num2str(curtick(:)))); % remove scientific multipliers in x-axis format
xlabel('time (s)');

extra_axis_options = 'xticklabel style={/pgf/number format/1000 sep=, /pgf/number format/precision=0,/pgf/number format/fixed,/pgf/number format/fixed zerofill,},yticklabel style={/pgf/number format/1000 sep=, /pgf/number format/precision=2, /pgf/number format/fixed, }, ylabel absolute,';
custom_m2t_fcn('ce_at_cc_1Cdischg',[figW_cm,figH_cm]*10,[],false,extra_axis_options);
close;

return;
