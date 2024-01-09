import Sortable from 'sortablejs';

const initSortable = (elements) => {
  elements.forEach((ul) => {
    new Sortable(ul, {
        group: 'shared', // set both lists to same group
        animation: 300,
        onEnd: function (evt) {
          var jobId = evt.item.id; // assumes each job item has an id attribute with the job's id
          var newStatus = evt.to.id;
          // TODO: make an AJAX request to update the job's status
          console.log(evt.item, evt.to)
        },
      });
  });
};
export { initSortable };
