function hydrateIcons(root=document){root.querySelectorAll('[data-icon]').forEach(el=>{el.innerHTML=wavvyIcon(el.dataset.icon);el.removeAttribute('data-icon')})}
hydrateIcons();
